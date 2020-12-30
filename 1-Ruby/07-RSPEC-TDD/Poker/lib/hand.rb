require_relative 'card.rb'

class Hand
    attr_reader :cards
    def initialize
        @cards = []
    end
    
    def add_card(new_card)
        raise "hand is already full!" if full?
        raise "input must be Card class" unless new_card.is_a?(Card)
        @cards << new_card
    end

    def full?
        @cards.length == 5
    end

    def category
    end
end