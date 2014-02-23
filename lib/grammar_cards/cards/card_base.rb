# encoding: utf-8

module GrammarCards
  module Cards

    # faux abstract superclass, mainly
    # just to document the interface of a card
    class CardBase
      attr_accessor :sequence_number
      def initialize
        @done = false
      end

      def done?
        @done
      end

      def mark_done
        @done = true
        @done.freeze
      end

      def front
      end

      def back
      end

    end
  end
end

