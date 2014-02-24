# encoding: utf-8
module GrammarCards
  module Cards
    class PossessiveAdjective < CardBase

      attr_reader :structure_data, :noun_data
      def initialize(noun_data, structure_data)
        @noun_data      = noun_data
        @owner          = structure_data[1]
        @structure_data = structure_data
        @noun           = GrammarCards::Words::Noun.new(:esp => noun_data[:esp],
                                                        :eng => noun_data[:eng],
                                                        :gen => noun_data[:gen],
                                                        :num => structure_data[0][:num])
        @phrase         = GrammarCards::Syntax::PossessiveAdjectivalNounPhrase.new(@noun, @owner)
        @done = false
      end

      def mark_done
        @done = true
        @done.freeze
        GrammarCards::Cards::PossessiveAdjectiveLogger.log self
      end

      def front
        unless @s
          @s = @phrase.english
          if note = GrammarCards::Characters.disambiguate_owner(@owner)
            @s += "\n(#{note})"
          end
        end
        @s
      end

      def back
        s = @phrase.spanish
        if s =~ /^sus?\s/
          s += "\n(#{GrammarCards::Syntax::PossessiveNounPhrase.spanish(@noun, @owner)})"
        end
        s
      end
    end
  end
end
