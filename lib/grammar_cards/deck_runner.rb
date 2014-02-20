# encoding: utf-8

module GrammarCards
  module DeckRunner

    def run
      deck = GrammarCards::Deck.new

      completed = 0
      TextDisplay.view(deck.size) do |view|
        card = deck.next
        while (card) do
          view.new_card(card.sequence_number)

          case view.show_front(card.front)
          when :quit
            break
          when :prev
            card = deck.prev
            next
          when :skip
            card = deck.next
            next
          end

          case view.show_back(card.back)
          when :quit
            break
          when :prev
            card = deck.prev
          else
            unless card.logged?
              completed += 1
              GrammarCards::CardLogger.log card
              card.set_logged
            end
            card = deck.next
          end

        end
      end

      puts "Completed #{completed} cards."
    end
    extend DeckRunner
  end
end
