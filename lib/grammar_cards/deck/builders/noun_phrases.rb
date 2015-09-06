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
            @deck_size = options[:deck_size]
            @all_nouns = get_all_nouns(options[:range])
            @unlogged_nouns = GrammarCards::Cards::NounPhraseLogger.unused_nouns(@all_nouns)
            @deck = []
          end

          def get_all_nouns(range)
            Psych.load_file(NOUN_FILE).select { |item| range.member?(item[:rnk].to_i) }
          end

          def build
            @deck_size.times do |i|
              n = random_noun_weighted_by_rank
              @deck << Cards::NounPhrase.new(n) if n
            end
            @deck
          end

          def unused_list
            unused = @unlogged_nouns - current_deck
            if unused.empty?
              all_nouns - current_deck
            else
              unused
            end
          end

          def current_deck
            @deck.map {|card| card.noun_data }
          end

          def random_noun_weighted_by_rank
            list = unused_list
            return if list.empty?
            candidate_list = []
            10.times do
              candidate_list << list[rand(list.size)]
            end
            min = candidate_list.first
            candidate_list.each do |noun|
              min = noun if noun[:rnk].to_i < min[:rnk].to_i
            end
            min
          end

        end

        def build(options = {})
          Builder.new({:deck_size => 12, :range => 0..5000}.merge(options)).build
        end

        extend NounPhrases
      end
    end
  end
end
