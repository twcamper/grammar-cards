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

    # nouns unused in past runs by the current structure
    def unused_nouns(structure_record, noun_superset)
      (@@log_file ||= GrammarCards::CardLogger::LogFile.new).
        nouns_unused_by(structure_record, noun_superset)
    end

    def candidate_list(structure_record)
      unused_nouns(structure_record, nouns_by_gender(structure_record[0][:gen]))
    end

    def random_noun(structure_record)
      list = candidate_list(structure_record)
      list[rand(list.size)]
    end

    def build
      deck = []
      shuffle_structures.each do |structure_record|
        deck << Card.new(random_noun(structure_record), structure_record)
      end
      deck
    end

    extend DeckBuilder
  end
end
