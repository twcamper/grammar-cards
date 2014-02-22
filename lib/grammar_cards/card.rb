# encoding: utf-8
module GrammarCards
  class Card

    attr_accessor :structure_data, :noun_data, :sequence_number
    def initialize(noun_data, structure_data, seq)
      @noun_data      = noun_data
      @owner          = structure_data[1]
      @structure_data = structure_data
      @noun           = GrammarCards::Words::Noun.new(:esp => noun_data[:esp],
                                                      :eng => noun_data[:eng],
                                                      :gen => noun_data[:gen],
                                                      :num => structure_data[0][:num])
      @phrase         = GrammarCards::Syntax::PossessiveAdjectivalNounPhrase.new(@noun, @owner)
      @sequence_number = seq
      @done = false
    end

    def done?
      @done
    end

    def mark_done
      @done = true
      @done.freeze
      GrammarCards::CardLogger.log self
    end

    def front
      s = @phrase.english
      if note = GrammarCards::Annotations.disambiguate_owner(@owner)
        s += " (#{note})"
      end
      s
    end

    def back
      s = @phrase.spanish
      if s =~ /^sus?\s/
        s += " (#{GrammarCards::Syntax::PossessiveNounPhrase.spanish(@noun, @owner)})"
      end
      s
    end
  end
end
