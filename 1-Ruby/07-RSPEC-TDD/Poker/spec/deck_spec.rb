require 'rspec'
require 'deck'

describe Deck do
    subject(:deck) {Deck.new}
    describe "#initialize" do
        it "puts 52 cards in the deck" do 
            expect(deck.cards.length).to eq(52)
        end
        it "no card is repeated" do 
            expect(Set.new(deck.cards).length).to eq(deck.cards.length)
        end
        it "has 13 each clubs, hearts, spades, diamonds" do 
            counts = {"♤" => 0,
                        "♡" => 0, 
                        "♢" => 0,
                        "♧" => 0}
            deck.cards.each { |card| counts[card.suit] += 1 }
            expect(counts.values.all?{|val| val == 13}).to be true
        end
    end

    describe "#shuffle!" do 
        let(:other_deck) {Deck.new}
        it "randomizes the order of cards"  do 
            deck.shuffle!
            other_deck.shuffle
            expect(deck.cards).not_to eq(other_deck.cards)
        end
        # check if deck is equal before & after shuffle. 
        # astronomically small chance to fail...
    end
    
    describe "#draw" do 
        it "removes a Card from the deck"
        it "returns the removed Card"
    end

    describe "#replace" do
        it "raises an error if the Card is already in the deck"
        it "adds the Card to the deck"
    end
end