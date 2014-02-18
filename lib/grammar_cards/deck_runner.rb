# encoding: utf-8
module GrammarCards
  module DeckRunner
    def run
      deck = GrammarCards::DeckBuilder.build

      deck.each_with_index do |card, i|
        printf("%3d) %s", i, card.front)
        STDIN.gets
        printf("\t%s\n", card.back)
      end
    end
    extend DeckRunner
  end
end
