require_relative 'card'
require 'byebug'

class Deck
    attr_reader :cards
    VALUES = ("2".."10").to_a + ["J", "Q", "K", "A"]
    SUITS = ["clubs","diamonds","hearts","spades"]
    
    def initialize
        @cards = []
        SUITS.each do |s|
            VALUES.each do |v|
                @cards << Card.new(v,s)
            end
        end
        @cards_set = Set.new(@cards)
    end

    def shuffle!
        @cards.shuffle!
    end

    def draw
        @cards.pop
    end

    def replace(c)
        raise("No duplicate cards allowed") if @cards.include?(c)
        @cards.unshift(c)
    end
end