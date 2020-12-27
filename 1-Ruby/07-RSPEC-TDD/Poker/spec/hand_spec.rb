require 'rspec'
require 'hand'

describe Hand do
    subject(:hand) {Hand.new}
    
    describe "#initialize" do
        it "initializes @cards as an empty array"
    end

    describe "#full?" do 
        it "returns false if less than 5 cards"
        it "returns true if 5 cards"
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