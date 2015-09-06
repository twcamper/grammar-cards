# encoding: utf-8
module GrammarCards
  module Cards
    class NounPhrase < CardBase

      attr_reader :noun_data
      def initialize(noun_data)
        @noun_data = noun_data
        @noun   = create_noun(noun_data)
        @article = GrammarCards::Words::DefiniteArticle.new(@noun.gender, noun_data[:num] || :s)
        @done   = false
      end

      def mark_done
        @done = true
        @done.freeze
        GrammarCards::Cards::NounPhraseLogger.log self
      end

      def front
        @noun.english
      end

      def back
        "%s %s\n\n(%s)" % [@article.spanish, @noun.spanish, @noun_data[:rnk]]
      end

      private
      def create_noun(noun_data)
        gender = case(noun_data[:gen])
                 when :m, :c, :a
                   :m
                 else
                   noun_data[:gen]
                 end
        GrammarCards::Words::Noun.new(:esp => noun_data[:esp],
                                      :eng => noun_data[:eng],
                                      :gen => gender,
                                      :num => :s)
      end
    end
  end
end
