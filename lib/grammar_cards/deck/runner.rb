# encoding: utf-8

module GrammarCards
  module Deck
    module Runner

      def run(deck)

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
            when :review
              next
            else
              unless card.done?
                completed += 1
                card.mark_done
              end
              card = deck.next
            end

          end
        end

        puts "Completed #{completed} cards."
      end
      extend Runner
    end
  end
end
