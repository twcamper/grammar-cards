#! /usr/bin/env ruby
require_relative '../lib/grammar_cards'

module GrammarCards
  module CLI

    def self.usage
      raise ArgumentError.new("Usage: #{$0} [count] [lowest_rank:highest_rank]")
    end

    usage if ARGV.size > 2
    OPTIONS = {}
    if ARGV[0]
      range = ARGV[0].split(":").map(&:to_i)
      usage if range.size != 2 || range.first > range.last
      OPTIONS[:range] = range.first..range.last
    end
    OPTIONS[:requested_size] = ARGV[1].to_i if ARGV[1]

  end
end
GrammarCards::Deck.run(
  GrammarCards::Deck::Deck.new(
    GrammarCards::Deck::Builders::NounPhrases.build( GrammarCards::CLI::OPTIONS )
  )
)
