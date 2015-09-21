#! /usr/bin/env ruby
require_relative '../lib/grammar_cards'

module GrammarCards
  module CLI

    def self.usage
      raise ArgumentError.new("Usage: #{$0} [-i|--ignore-log] [count] [lowest_rank:highest_rank]")
    end

    OPTIONS = {:ignore_log => false}
    if (ARGV.delete("-i") || ARGV.delete("--ignore-log"))
      OPTIONS[:ignore_log] = true
    end

    ARGV.delete_if { |arg| arg =~ /^-/ }

    usage if ARGV.size > 2
    if ARGV[0]
      usage if ARGV[0].include?(":")
      OPTIONS[:requested_size] = ARGV[0].to_i
    end
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
