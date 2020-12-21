require 'rspec'
require 'card'

describe Card do
    subject(:card) {Card.new("2","spades")}
    describe "#initialize" do 
        it "sets suit" do 
            expect(card.suit).to eq("♤")
        end
        it "sets value" do
            expect(card.value).to eq("2")
        end
    end

    describe "#to_s" do 
        it "prettifies suit and value in one string" do
            expect(card.to_s).to eq("|♤2|")
        end
    end
end