#! /usr/bin/env ruby
require_relative '../lib/grammar_cards'

module GrammarCards
  module CLI
p   DECKS = if ARGV.empty?
              GrammarCards::Deck::Builders.constants
            else
              ARGV.map {|arg| arg.to_sym}
            end
  end
end
GrammarCards::Deck.run(GrammarCards::Deck.build( *GrammarCards::CLI::DECKS ))
