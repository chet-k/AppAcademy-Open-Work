require 'rspec'
require 'hand'
require 'card'

describe Hand do
    subject(:hand) {Hand.new}
    let(:test_card) {Card.new("A","spades")}
    
    describe "#initialize" do
        it "initializes @cards as an empty array" do
            expect(hand.cards).to eq([])
        end
    end

    describe "#add_card" do 
        it "raises an error unless input is a Card" do
            expect{hand.add_card("A♤")}.to raise_error("input must be Card class")
        end
        
        it "adds input card to @cards" do
            hand.add_card(test_card)
            expect(hand.cards[0]).to equal(test_card)
        end
        
        it "calls self#full?" do
            expect(hand).to receive(:full?)
            hand.add_card(test_card)
        end

        it "raises an error if hand is already full" do 
            5.times {hand.add_card(test_card)}
            expect{hand.add_card(test_card)}.to raise_error("hand is already full!")
        end
    end

    describe "#full?" do 
        it "calls Array#length on @cards array" do
            expect(hand.cards).to receive(:length)
            hand.full?
        end
        it "returns false for less than 5 cards" do 
            expect(hand.full?).to be false
        end
        it "returns true for 5 cards" do
            5.times {hand.add_card(test_card)}
            expect(hand.full?).to be true
        end
    end

    describe "#category" do 
        it "returns 1 for a straight flush"
        it "returns 2 for four of a kind"
        it "returns 3 for a full house"
        it "returns 4 for a flush"
        it "returns 5 for a 5-card straight"
        it "returns 6 for 3 of a kind"
        it "returns 7 for two pair"
        it "returns 8 for a pair"
        it "returns 9 for high card"
    end

    describe "#==" do
        it "returns true if the hands tie"
        it "returns false if the hands do not tie"
    end

    describe "#>" do
        it "returns true if self#category is a better rank (lower) than input hand"
        it "ranks flush, straight, 2-3-4 of a kind by high card"
        it "ranks full house by triplet first, then pair"
        it "ranks 2 pair by highest pair, then 2nd highest, then by 5th card"
    end
end