# encoding: utf-8
require 'date'

module GrammarCards
  module Deck
    module Builders
      module Endings
        extend DeckHelper

        DATA_PATH = File.expand_path('../data', File.dirname($0))

        def build
          deck = []
          db = GrammarCards::Verbs.new
          Dir["#{DATA_PATH}/lexis/verbs/*"].each do |file|
            File.read(file).split.each do |verb|
              deck << GrammarCards::Cards::Ending.new(db.english(verb), verb)
            end
          end
          db.disconnect
          shuffle deck
        end

        extend Endings
      end
    end
  end
end
