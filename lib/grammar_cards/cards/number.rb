# encoding: utf-8
module GrammarCards
  module Cards
    class Number

      attr_accessor :sequence_number
      def initialize(n)
        @n = n
        @spanish = GrammarCards::Numbers.spanish_words_for(n)
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
        @n.to_s
      end

      def back
        @spanish
      end
    end
  end
end
