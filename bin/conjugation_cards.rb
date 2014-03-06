#! /usr/bin/env ruby
require_relative '../lib/grammar_cards'

GrammarCards::Deck.run(
  GrammarCards::Deck::Deck.new(
    GrammarCards::Deck::Builders::Conjugations.build(:Presente, :Indicativo)
  )
)