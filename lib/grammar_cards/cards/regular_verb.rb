# encoding: utf-8

module GrammarCards
  module Cards
    class RegularVerb < CardBase

      attr_reader :front, :back
      def initialize(verb, subject)
        pronoun = GrammarCards::Words::PersonalPronoun.spanish(subject)
        @front = "#{verb[:eng]}\n\n(#{pronoun})"
        @back  = "#{pronoun} #{GrammarCards::Words::RegularVerb.spanish(verb[:esp], subject)}\n\n(#{verb[:esp]})"
        @done = false
      end

    end
  end
end
