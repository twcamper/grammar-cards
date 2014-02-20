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

    # m, f, or both
    def nouns_by_gender(gender)
      @@noun_data ||= Psych.load_file(NOUN_FILE)
      case gender
      when :m
        @@masculine ||= @@noun_data.select {|n| n[:gen] == :m}
      when :f
        @@feminine  ||= @@noun_data.select {|n| n[:gen] == :f}
      else
        @@noun_data
      end

    end
    def candidate_list(structure_record)
      # debug structure_record.inspect
      used_nouns = []
      i = log_data.index do |item|
        item[0] == structure_record[0] && item[1] == structure_record[1]
      end
      # debug "index '#{i}'"
      if i
        used_nouns = log_data[i][2] || []
      end

      nouns = nouns_by_gender(structure_record[0][:gen])
      diff = nouns - used_nouns

      if diff.empty? # all nouns have been used
        log_data[i][2] = []
        GrammarCards::CardLogger.dump log_data
        nouns
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
