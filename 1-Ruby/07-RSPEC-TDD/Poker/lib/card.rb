class Card
    attr_reader :value, :suit, :rank
    RANKS = (("2".."10").to_a + ["J", "Q", "K", "A"]).reverse
    SUITS = {"spades" => "♤",
            "hearts" => "♡", 
            "diamonds" => "♢",
            "clubs" => "♧"}

    def initialize(value, suit)
        @value = value
        @suit = SUITS[suit]
        @rank = RANKS.index(@value)
    end

    def to_s
        "|" + @suit + @value + "|"
    end

    def ==(other_card)
        other_card.suit == @suit && other_card.value == @value
    end
end