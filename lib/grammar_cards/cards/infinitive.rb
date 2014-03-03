# encoding: utf-8

module GrammarCards
  module Cards

    class Infinitive
      attr_accessor :sequence_number
      attr_reader :front, :back
      def initialize(front, back)
        @front = front
        @back = back
        @done = false
      end

      def done?
        @done
      end

      def mark_done
        @done = true
        @done.freeze
      end

    end
  end
end

