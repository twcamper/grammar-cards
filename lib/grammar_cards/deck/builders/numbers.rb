# encoding: utf-8

module GrammarCards
  module Deck
    module Builders
      module Numbers

        def build
          numbers = []
          4.times do
            numbers << rand(1000) + 100
          end
          numbers << rand(255)
          5.times do
            numbers << rand(998999) + 1000
          end

          numbers.map do |n|
            GrammarCards::Cards::Number.new n
          end
        end
        extend Numbers
      end
    end
  end
end
