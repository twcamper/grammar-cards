# encoding: utf-8
require 'active_support/number_helper'

module GrammarCards
  module Cards
    class Arithmetic < CardBase

      def initialize(left_operand, right_operand, operator)
        @math = "#{format_number(left_operand)} #{operator} #{format_number(right_operand)}"
        @spanish = GrammarCards::Numbers.equation(left_operand, right_operand, operator)
        @done = false
      end

      def format_number(n)
        ActiveSupport::NumberHelper.number_to_delimited(n, :delimiter => ".")
      end

      def front
        @math
      end

      def back
        @spanish
      end
    end
  end
end
