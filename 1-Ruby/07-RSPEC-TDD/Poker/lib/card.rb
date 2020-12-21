class Card
    SUITS = {"spades" => "♤",
            "hearts" => "♡", 
            "diamonds" => "♢",
            "clubs" => "♧"}

    attr_reader :value, :suit

    def initialize(value, suit)
        @value = value
        @suit = SUITS[suit]
    end

    def to_s
        "|" + @suit + @value + "|"
    end

    def ==(other_card)
        other_card.suit == @suit && other_card.value == @value
    end
end