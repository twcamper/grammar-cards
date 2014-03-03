# encoding: utf-8
require 'date'

module GrammarCards
  module Deck
    module Builders
      module Infinitives
        extend DeckHelper

          DATA_PATH = File.expand_path('../data', File.dirname($0))

        def build
          deck = []
          ['ar', 'er', 'ir'].each do |verb_type|
            verbs = Psych.load_file(File.join(DATA_PATH, "lexis", "verbos-regolares-#{verb_type}.yml"))
            verbs.each do |pair|
              deck << GrammarCards::Cards::Infinitive.new(pair[:eng], pair[:esp])
            end
          end
          shuffle deck
        end

        extend Infinitives
      end
    end
  end
end
