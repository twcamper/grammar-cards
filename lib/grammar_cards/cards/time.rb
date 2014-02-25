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
        s = ( h == 1 ?  "Es la" : "Son las" )
        s << " #{GrammarCards::Numbers.spanish_words_for(h)} y #{GrammarCards::Numbers::spanish_words_for(time.min)}"
      end
    end
  end
end
