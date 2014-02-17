# encoding: utf-8
module GrammarCards
  class Card
    def initialize(noun, owner)
      @noun, @owner = noun, owner
      @phrase = GrammarCards::Syntax::PossessiveAdjectivalNounPhrase.new(noun, owner)
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
