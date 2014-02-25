# encoding: utf-8
require 'date'

module GrammarCards
  module Deck
    module Builders
      module Numbers
        extend DeckHelper

        def build
          numbers = []
          2.times do
            numbers << rand(1000) + 100
          end
          4.times do
            numbers << rand(998999) + 1000
          end

          deck = numbers.map do |n|
            GrammarCards::Cards::Number.new n
          end
          deck << GrammarCards::Cards::Time.new( random_clock)
          deck << GrammarCards::Cards::Arithmetic.new(rand(100) + 1900, rand(99), random_operator)
          deck << GrammarCards::Cards::Arithmetic.new(1492, Date.today.day, :+)
          2.times do
            deck << GrammarCards::Cards::Arithmetic.new(rand(100), rand(50), random_operator)
          end

          shuffle deck
        end

        def random_clock
          [12, 24][rand(2)]
        end
        def random_operator
          [:-, :+][rand(2)]
        end

        extend Numbers
      end
    end
  end
end
