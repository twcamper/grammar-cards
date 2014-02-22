# encoding: utf-8
require_relative 'deck/runner'
require_relative 'deck/builders/possessive_adjectives'

module GrammarCards
  module Deck
    def run(deck)
      Runner.run deck
    end

    # for an arbitrary length list of decks varying sizes
    #
    # 1 - sort the list by size, from greatest array length to least
    # 2 - get a ratio for each successive pair in the list, such that
    #     n arrays will have n-1 ratios, between 0:1, 1:2, 2:3 etc
    # 3 - construct an array whose size is the total of the sizes of all the arrays
    #      - each array lets its smaller following neighbor continue to adding elements
    #        based on the ratio between them, and the smaller decides whether to let ITS
    #        smaller neighbor continue, or to go back its bigger preceding neighbor based
    #        on its ratio with the smaller one to the right.
    def build(*builders)
      composite_deck = []
      decks = builders.map { |b| Builders.const_get(b).build}

      if decks.size > 1
        if decks[0].size > decks[1].size
          bigger = decks[0]
          smaller = decks[1]
        else
          bigger = decks[1]
          smaller = decks[0]
        end
        ratio = (bigger.to_f / smaller.to_f).round
        (bigger.size + smaller.size).times do
          ratio.times do
            composite_deck << bigger.shift
          end
          composite << smaller.shift
        end
        composite += bigger unless bigger.empty?
      else
        composite_deck = decks.flatten
      end

      Deck.new composite_deck
    end
    class Deck

      def initialize(cards)
        raise "Empty deck" if cards.empty?
        @cards = cards
        @index = -1
      end

      def size
        @cards.size
      end

      def next
        return nil if @index >= @cards.size
        @cards[@index += 1]
      end

      def prev
        return @cards.first if @index < 1
        @cards[@index -= 1]
      end

    end

    extend GrammarCards::Deck
  end
end
