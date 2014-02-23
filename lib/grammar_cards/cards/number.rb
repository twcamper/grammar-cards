# encoding: utf-8
require 'active_support/number_helper'

module GrammarCards
  module Cards
    class Number < CardBase

      def initialize(n)
        @n = n
        @spanish = GrammarCards::Numbers.spanish_words_for(n)
        @done = false
      end

      def front
        ActiveSupport::NumberHelper.number_to_delimited(@n, :delimiter => ".")
      end

      def back
        @spanish
      end
    end
  end
end
