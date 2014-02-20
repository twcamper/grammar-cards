# encoding: utf-8

module GrammarCards
  class Deck

    def initialize
      @cards = GrammarCards::DeckBuilder.build
      raise "Empty deck" if @cards.empty?
      @index = -1
    end

    def size
      @cards.size
    end

    def next
      return nil if @index >= @cards.size
      @cards[@index += 1]
    end

    def prev
      return @cards.first if @index < 1
      @cards[@index -= 1]
    end

  end
end
