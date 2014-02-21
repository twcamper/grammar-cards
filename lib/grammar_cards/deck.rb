# encoding: utf-8
require_relative 'deck/runner'
require_relative 'deck/builders/possessive_adjectives'

module GrammarCards
  module Deck
    def run(deck)
      Runner.run deck
    end

    def build(*decks)
      Deck.new Builders::PossessiveAdjectives.build
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
