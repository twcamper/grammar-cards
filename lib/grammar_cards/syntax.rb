# encoding: utf-8

module GrammarCards
  module Syntax
    module PossessiveNounPhrase
      def spanish(noun, owner)
        phrase = GrammarCards::Words::DefiniteArticle.new(noun.gender, noun.number).spanish
        phrase += " "
        phrase += noun.spanish
        phrase += " de"
        phrase += " "
        phrase += GrammarCards::Words::PossessivePronoun.spanish(owner[:per], owner[:num], owner[:gen])
      end
      extend PossessiveNounPhrase
    end

    class PossessiveAdjectivalNounPhrase

      def initialize(noun, owner)
        @noun, @owner = noun, owner
        @adj = GrammarCards::Words::PossessiveAdjective.new(@owner, {:gen => @noun.gender, :num => @noun.number})
      end

      def spanish
        @adj.spanish + ' ' + @noun.spanish
      end

      def english
        @adj.english + ' ' + @noun.english
      end

    end
  end
end
