# encoding: utf-8
require 'time'

module GrammarCards
  module Cards
    class Time < CardBase

      def initialize(clock)
        @clock = clock
        @hour_format = (clock == 24 ? "%H" : "%I")
        @done = false
      end

      def front
        "¿Qué hora es?\n\n(#{@clock}h)"
      end

      def back
        time = ::Time.now
        h = time.strftime(@hour_format).to_i
        GrammarCards::Numbers.time h, time.min
      end
    end
  end
end
