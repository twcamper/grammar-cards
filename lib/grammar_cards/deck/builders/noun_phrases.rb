# encoding: utf-8

module GrammarCards
  module Deck
    module Builders
      module NounPhrases
        extend DeckHelper

        DATA_PATH = File.expand_path('../data', File.dirname($0))
        NOUN_FILE = File.join(DATA_PATH, "lexis", "nouns-from-top-5000.yml")

        class Builder
          def initialize(options)
            @options = options
            all_nouns = Psych.load_file(NOUN_FILE).select { |item| options[:range].member?(item[:rnk].to_i) }
            @logger = GrammarCards::Cards::NounPhraseLogger.new
            @available_nouns = all_nouns - @logger.logged_nouns
            @deck_size = calculate_deck_size
            @deck = []
          end

          def calculate_deck_size
            if (requested_size = @options[:requested_size])
              min = requested_size
              min = @available_nouns.size if @available_nouns.size < requested_size
              min
            else
              @available_nouns.size
            end
          end

          def build
            @deck_size.times do |i|
              n = random_noun
              @deck << Cards::NounPhrase.new(n, @logger) if n
            end
            @deck
          end

          def current_deck
            @deck.map {|card| card.noun_data }
          end

          def random_noun
            unused = @available_nouns - current_deck
            unused[rand(unused.size)]
          end
        end

        def build(options = {})
          Builder.new({:range => 0..5000}.merge(options)).build
        end

        extend NounPhrases
      end
    end
  end
end
