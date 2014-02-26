# encoding: utf-8

module GrammarCards
  module Cards
    class RegularVerb < CardBase

      attr_reader :front, :back, :structure_data, :word_data
      def initialize(verb, subject)
        pronoun = GrammarCards::Words::PersonalPronoun.spanish(subject)
        @front = "#{verb[:eng]}\n\n(#{pronoun})"
        @back  = "#{pronoun} #{GrammarCards::Words::RegularVerb.spanish(verb[:esp], subject)}\n\n(#{verb[:esp]})"
        @structure_data = [subject]
        @word_data = verb[:esp]
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
