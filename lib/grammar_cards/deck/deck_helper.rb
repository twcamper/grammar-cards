# encoding: utf-8

module GrammarCards
  module Deck
    module DeckHelper

      def shuffle(deck)
        shuffled = []
        until deck.empty?
          shuffled << deck.delete_at(rand(deck.size))
        end
        shuffled
      end
    end
  end
end
