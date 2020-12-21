require_relative 'card'

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
    end

    def shuffle
    end

    def draw
    end

    def replace
    end
end