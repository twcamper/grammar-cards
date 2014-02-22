# encoding: utf-8

module GrammarCards
  module Deck
    module Builders
      module Numbers

        def build
          [16, 89, 1508, 99901, 432, 55, 101, 2000].map do |n|
            GrammarCards::Cards::Number.new n
          end
        end
        extend Numbers
      end
    end
  end
end
