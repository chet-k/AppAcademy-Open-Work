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
            other_deck.shuffle!
            expect(deck.cards).not_to eq(other_deck.cards)
        end
    end
    
    describe "#draw" do 
        it "removes a Card from the deck" do
            deck.draw
            expect(deck.cards.length).to eq(51)
        end
        it "returns the removed Card" do
            c = deck.draw
            expect(c.is_a?(Card)).to be true
        end
    end

    describe "#replace" do
        it "adds the Card to the deck" do
            c1 = deck.draw
            c2 = deck.draw
            deck.replace(c1)
            expect(deck.cards.length).to eq(51)
            expect(deck.cards.include?(c1)).to be true
        end
        it "raises an error if the Card is already in the deck" do 
            card = deck.draw
            deck.replace(card)
            expect{deck.replace(card.dup)}.to raise_error("No duplicate cards allowed")
        end        
    end
end