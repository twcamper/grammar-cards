# encoding: utf-8

module GrammarCards
  module Cards
    class RegularVerb < CardBase

      attr_reader :front, :back, :verb_form, :word_data
      def initialize(verb, verb_form)
        pronoun = GrammarCards::Words::PersonalPronoun.random_pronoun_for(verb_form)
        @front = "#{verb[:eng]}\n\n(#{pronoun})"
        @back  = "#{pronoun} #{GrammarCards::Words::RegularVerb.spanish(verb[:esp], verb_form)}\n\n(#{verb[:esp]})"
        @verb_form = verb_form
        @word_data = verb
        @done = false
      end

      def mark_done
        @done = true
        @done.freeze
        GrammarCards::Cards::RegularVerbLogger.log self
      end

    end
  end
end
