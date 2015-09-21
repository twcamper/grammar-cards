# encoding: utf-8

module GrammarCards
  module Deck
    module Builders
      module NounPhrases
        extend DeckHelper

        DATA_PATH = File.expand_path('../data', File.dirname($0))
        NOUN_FILE = File.join(DATA_PATH, "lexis", "nouns-from-top-5000.freq.yml")
        DEFAULT_RANGE = 0..5000

        class Builder
          def initialize(options)
            @options = options
            @logger = GrammarCards::Cards::NounPhraseLogger.new(@options[:ignore_log])
            @available_nouns = nouns_in_range - @logger.logged_nouns
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
              @deck << Cards::NounPhrase.new(@available_nouns[i], @logger)
            end
            @deck
          end

          def current_deck
            @deck.map {|card| card.noun_data }
          end

          def nouns_in_range
            all_nouns = Psych.load_file(NOUN_FILE)

            return all_nouns if @options[:range] == DEFAULT_RANGE
            filtered = []
            all_nouns.each do |item|
              filtered << item if @options[:range].member?(item[:rnk].to_i)
              break if item[:rnk].to_i > @options[:range].end
            end
            filtered
          end
        end

        def build(options = {})
          shuffle Builder.new({:range => DEFAULT_RANGE,
                               :requested_size => 16,
                               :ignore_log => false}.merge(options)).build
        end

        extend NounPhrases
      end
    end
  end
end
