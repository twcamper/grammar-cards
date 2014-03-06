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
          db = GrammarCards::Verbs.new
          Dir["#{DATA_PATH}/lexis/verbs/*"].each do |file|
            File.read(file).split.each do |verb|
              deck << GrammarCards::Cards::Infinitive.new(db.english(verb), verb)
            end
          end
          db.disconnect
          shuffle deck
        end

        extend Infinitives
      end
    end
  end
end
