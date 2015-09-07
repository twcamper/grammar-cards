# encoding: utf-8
module GrammarCards
  module Cards
    class NounPhrase < CardBase

      attr_reader :noun_data
      def initialize(noun_data, logger)
        @noun_data = noun_data
        @logger = logger
        @noun   = create_noun(noun_data)
        @article = GrammarCards::Words::DefiniteArticle.new(@noun.gender, noun_data[:num] || :s)
        @done   = false
        @logged = false
      end

      def log
        unless @logged
          @logged = true
          @logger.log self
        end
      end

      def front
        @noun_data[:eng]
        "%s\n\n(%s)" % [@noun_data[:eng], @noun_data[:rnk]]
      end

      def back
        "%s %s" % [@article.spanish, @noun.spanish]
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
                                      :num => noun_data[:num])
      end
    end
  end
end
