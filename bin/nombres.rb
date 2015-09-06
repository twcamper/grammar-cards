#! /usr/bin/env ruby
require_relative '../lib/grammar_cards'

module GrammarCards
  module CLI

    def self.usage
      raise ArgumentError.new("Usage: #{$0} [count] [lowest_rank:highest_rank]")
    end

    usage if ARGV.size > 2
    OPTIONS = {}
    OPTIONS[:deck_size] = ARGV[0].to_i if ARGV[0]
    if ARGV[1]
      range = ARGV[1].split(":").map(&:to_i)
      usage if range.size != 2 || range.first > range.last
      OPTIONS[:range] = range.first..range.last
    end

  end
end
GrammarCards::Deck.run(
  GrammarCards::Deck::Deck.new(
    GrammarCards::Deck::Builders::NounPhrases.build( GrammarCards::CLI::OPTIONS )
  )
)
