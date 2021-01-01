require 'rspec'
require 'player'

describe Player do 
    subject(:player) {Player.new}

    describe "#initialize" do 
        it "initializes @hand as an empty hand"
        it "initializes @funds as 0"
        it "sets @folded to false"
    end

    describe "#bet" do 
        it "raises an error if bet amount is not integer > 0"
        it "raises an error if not enough @funds for bet amount"
        it "removes bet amount from @funds"
        it "returns bet amount"
    end

    describe "#fold" do 
        it "sets @folded to true"
    end

    describe "#see" do 
    end

    describe "#raise" do 
    end

    describe "#reset" do 
        it "sets @folded to false"
        it "returns all cards in hand to the deck"
        it "sets @hand to an empty hand"
    end
    
end
