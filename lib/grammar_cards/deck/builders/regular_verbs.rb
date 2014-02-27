# encoding: utf-8
require 'date'

module GrammarCards
  module Deck
    module Builders
      module RegularVerbs
        extend DeckHelper

        class Builder

          DATA_PATH = File.expand_path('../data', File.dirname($0))
          VERB_FORMS = [0, 1, 2, 3, 4, 5]

          def initialize(verb_type)
            @verbs = Psych.load_file(File.join(DATA_PATH, "lexis", "verbos-regolares-#{verb_type}.yml"))
            @log_file = GrammarCards::Cards::RegularVerbLogger::LogFile.new verb_type
          end

          def unused_verbs(form)
            @log_file.words_unused_by(form, @verbs)
          end

          def candidate_list(verb_form)
            unused = unused_verbs(verb_form)
            if (diff = unused - used_in_this_deck).empty?
              unused
            else
              diff
            end
          end

          def used_in_this_deck
            @used_in_this_deck ||= []
          end

          def random_verb(verb_form)
            list = candidate_list(verb_form)
            used_in_this_deck << list[rand(list.size)]
            used_in_this_deck.last
          end

          def build
            deck = []
            VERB_FORMS.each do |form|
              deck << GrammarCards::Cards::RegularVerb.new(random_verb(form), form)
            end
            deck
          end
        end

        def build
          deck = Builder.new(:ar).build +
                 Builder.new(:er).build +
                 Builder.new(:ir).build

          shuffle deck
        end

        extend RegularVerbs
      end
    end
  end
end
