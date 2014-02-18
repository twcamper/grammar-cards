# encoding: utf-8

module GrammarCards
  module DeckRunner

    def run
      deck = GrammarCards::DeckBuilder.build

      completed = 0
      TextDisplay.view(deck.size) do |view|
        deck.each_with_index do |card, i|
          view.new_card(i + 1)
          view.show_front(card.front)
          break unless view.continue?
          view.show_back(card.back)
          completed += 1
          break unless view.continue?
        end
      end

      puts "Completed #{completed} cards."
    end
    extend DeckRunner
  end
end
