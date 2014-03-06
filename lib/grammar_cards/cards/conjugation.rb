# encoding: utf-8

module GrammarCards
  module Cards
    class Conjugation < CardBase

      attr_reader :front, :back, :verb_type, :verb_form, :word_data
      def initialize(verb_type, verb_form, verb)
        @verb_type = verb_type
        pronoun = GrammarCards::Words::PersonalPronoun.random_pronoun_for(verb_form)
        @front = "#{verb[:eng]}\n\n(#{pronoun})"
        @back  = "#{pronoun} #{verb[:esp]}\n\n(#{verb[:inf]})"
        @verb_form = verb_form
        @word_data = verb[:inf]
        @done = false
      end

      def mark_done
        @done = true
        @done.freeze
        GrammarCards::Cards::ConjugationLogger.log self
      end

    end
  end
end
