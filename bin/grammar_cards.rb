#! /usr/bin/env ruby
require_relative '../lib/grammar_cards'

GrammarCards::Deck.run(
  GrammarCards::Deck.build(
    :PossessiveAdjectives,
    :Numbers
)
)
