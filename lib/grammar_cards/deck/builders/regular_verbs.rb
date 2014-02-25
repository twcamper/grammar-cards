# encoding: utf-8
require 'date'

module GrammarCards
  module Deck
    module Builders
      module RegularVerbs
        extend DeckHelper

        DATA_PATH = File.expand_path('../data', File.dirname($0))
        VERB_FILE = File.join(DATA_PATH, "lexis", "verbos-regolares.yml")
        SUBJECT_STRUCTURE_FILE = File.join(DATA_PATH, "structure", "reg-verb-subjects.yml")

        def subjects
          @@subject ||= shuffle(Psych.load_file(SUBJECT_STRUCTURE_FILE))
        end

        def verb_data
          @@verb_data ||= Psych.load_file(VERB_FILE)
        end

        def build
          deck = []
          ['ar', 'er', 'ir'].each do |ending|
            verbs = verb_data.select {|v| v[:esp] =~ /#{ending}$/}

            subjects.each do |s|
              deck << GrammarCards::Cards::RegularVerb.new(verbs[rand(verbs.size)], s)
            end
          end
          shuffle deck
        end

        extend RegularVerbs
      end
    end
  end
end
