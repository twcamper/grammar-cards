# encoding: utf-8

module GrammarCards
  module Cards

    class Infinitive < CardBase
      attr_reader :front, :back
      def initialize(front, back)
        @front = front
        @back = back
        @done = false
      end

    end
  end
end

