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
          Dir["#{DATA_PATH}/lexis/verbs/*"].each do |file|
            File.read(file).split.each do |verb|
              deck << GrammarCards::Cards::Infinitive.new(GrammarCards::Verbs.english(verb), verb)
            end
          end
          shuffle deck
        end

        extend Infinitives
      end
    end
  end
end
