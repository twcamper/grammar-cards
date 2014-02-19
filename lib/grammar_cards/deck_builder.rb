# encoding: utf-8
gem 'psych'
require 'psych'  # YAML implementation

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

    def build
      noun_data = Psych.load_file(NOUN_FILE)
      structure_data = shuffle_structures
      deck = []
      structure_data.each_with_index do |record, i|
        noun_data[i][:num] = record[0][:num]
        deck << Card.new( GrammarCards::Words::Noun.new(noun_data[i]), record[1])
      end
      deck
    end

    extend DeckBuilder
  end
end
