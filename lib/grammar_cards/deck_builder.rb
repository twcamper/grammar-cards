# encoding: utf-8

module GrammarCards
  module DeckBuilder

    DATA_PATH = File.expand_path('../data', File.dirname($0))
    NOUN_FILE = File.join(DATA_PATH, "nombres-sostantivos.yml")
    POSSESSIVE_ADJECTIVE_STRUCTURE_FILE = File.join(DATA_PATH, "adjetivos-posesivos.yml")

    def shuffle_structures
      ordered_structures = Psych.load_file(POSSESSIVE_ADJECTIVE_STRUCTURE_FILE)

      shuffled = []
      until ordered_structures.empty?
        shuffled << ordered_structures.delete_at(rand(ordered_structures.size))
      end
      shuffled
    end

    def log_data
      @@log_data ||= GrammarCards::CardLogger.read_log_file
    end

    def random_noun(structure_record)
      list = candidate_list(structure_record)
      list[rand(list.size)]
    end
    def debug(s)
      File.open('debug', "a") {|f| f.puts s }
    end

    def candidate_list(structure_record)
      @@noun_data ||= Psych.load_file(NOUN_FILE)
      # debug structure_record.inspect
      used_nouns = []
      i = log_data.index do |item|
        item[0] == structure_record[0] && item[1] == structure_record[1]
      end
      # debug "index '#{i}'"
      if i
        used_nouns = log_data[i][2] || []
      end

      raw_list = if structure_record[0][:gen]
        @@noun_data.select {|n| n[:gen] == structure_record[0][:gen] }
      else
        @@noun_data
      end
      diff = raw_list - used_nouns

      if diff.empty? # all nouns have been used
        GrammarCards::CardLogger.dump log_data
        raw_list
      else
        diff
      end
    end

    def build
      deck = []
      shuffle_structures.each do |record|
        deck << Card.new(random_noun(record), record)
      end
      deck
    end

    extend DeckBuilder
  end
end
