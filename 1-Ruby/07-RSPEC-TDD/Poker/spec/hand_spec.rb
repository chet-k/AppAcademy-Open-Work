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
        it "returns 1 for a straight flush" do 
            cards = [Card.new("6","hearts"), Card.new("2","hearts"), Card.new("3","hearts"), Card.new("4","hearts"), Card.new("5","hearts")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(1)
        end
        it "returns 2 for four of a kind" do 
            cards = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("6","spades"), Card.new("6","clubs"), Card.new("5","hearts")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(2)
        end
        it "returns 3 for a full house" do
            cards = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("6","clubs")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(3)
        end
        it "returns 4 for a flush" do
            cards = [Card.new("6","hearts"), Card.new("8","hearts"), Card.new("J","hearts"), Card.new("A","hearts"), Card.new("3","hearts")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(4)
        end
        it "returns 5 for a 5-card straight" do 
            cards = [Card.new("6","hearts"), Card.new("2","diamonds"), Card.new("3","clubs"), Card.new("4","hearts"), Card.new("5","hearts")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(5)            
        end
        it "returns 6 for 3 of a kind" do
            cards = [Card.new("6","hearts"), Card.new("K","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("7","hearts")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(6)
        end
        it "returns 7 for two pair" do 
            cards = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("K","clubs")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(7)
        end
        it "returns 8 for a pair" do 
            cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("A","spades"), Card.new("J","clubs"), Card.new("9","diamonds")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(8)
        end
        it "returns 9 for high card" do 
            cards = [Card.new("K","hearts"), Card.new("Q","diamonds"), Card.new("7","spades"), Card.new("4","spades"), Card.new("3","clubs")]
            cards.each {|c| hand.add_card(c)}
            expect(hand.category).to eq(9)
        end
    end

    describe "#==" do
        let(:other_hand) {Hand.new}
        let(:cards) {[Card.new("K","hearts"), Card.new("Q","diamonds"), Card.new("7","spades"), Card.new("4","spades"), Card.new("3","clubs")]}

        it "returns true if the hands tie (duplicate sets of values)" do 
            cards.each {|c| hand.add_card(c)}
            cards2 = [Card.new("K","diamonds"), Card.new("Q","hearts"), Card.new("7","clubs"), Card.new("4","clubs"), Card.new("3","spades")]
            cards2.each {|c| other_hand.add_card(c)}
            expect(hand == other_hand).to be true
        end
        it "returns false if the hands do not tie" do 
            cards.each {|c| hand.add_card(c)}
            cards2 = [Card.new("A","diamonds"), Card.new("Q","hearts"), Card.new("7","clubs"), Card.new("4","clubs"), Card.new("3","spades")]
            cards2.each {|c| other_hand.add_card(c)}
            expect(hand == other_hand).to be false
        end
    end

    describe "#wins_against?" do
        let(:other_hand) {Hand.new}
        
        it "returns true if self#category is a better rank (lower) than input hand" do 
            cards = [Card.new("6","hearts"), Card.new("K","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("7","hearts")]
            cards.each {|c| hand.add_card(c)}
            cards2 = [Card.new("6","hearts"), Card.new("K","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("Q","hearts")]
            cards2.each {|c| other_hand.add_card(c)}
            expect(hand.wins_against?(other_hand)).to be true
        end

        it "ranks straight by high card" do 
            cards = [Card.new("6","hearts"), Card.new("2","diamonds"), Card.new("3","clubs"), Card.new("4","hearts"), Card.new("5","hearts")]
            cards.each {|c| hand.add_card(c)}
            cards2 = [Card.new("6","clubs"), Card.new("7","diamonds"), Card.new("3","spades"), Card.new("4","diamonds"), Card.new("5","diamonds")]
            cards2.each {|c| other_hand.add_card(c)}
            expect(hand.wins_against?(other_hand)).to be false
        end

        it "ranks full house by highest triplet" do 
            cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("6","spades"), Card.new("6","clubs"), Card.new("7","clubs")]
            cards.each {|c| hand.add_card(c)}
            cards2 = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("6","spades")]
            cards2.each {|c| other_hand.add_card(c)}
            expect(hand.wins_against?(other_hand)).to be true
        end
        
        context "flush or high-card" do 
            it "ranks by high card" do 
                cards = [Card.new("6","hearts"), Card.new("8","hearts"), Card.new("J","hearts"), Card.new("A","hearts"), Card.new("3","hearts")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("3","clubs"), Card.new("9","clubs"), Card.new("J","clubs"), Card.new("K","clubs"), Card.new("4","clubs")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end

            it "ranks by highest non-tied card" do 
                cards = [Card.new("6","diamonds"), Card.new("8","hearts"), Card.new("J","diamonds"), Card.new("A","hearts"), Card.new("3","hearts")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("3","spades"), Card.new("2","clubs"), Card.new("J","spades"), Card.new("A","clubs"), Card.new("5","spades")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
        end

        context "#-of-a-kind" do 
            it "ranks 2-of-a-kind by highest kind" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("A","spades"), Card.new("J","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("A","clubs"), Card.new("J","spades"), Card.new("9","hearts")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
            it "ranks tied pairs by high card" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("A","spades"), Card.new("J","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("7","clubs"), Card.new("7","spades"), Card.new("K","clubs"), Card.new("J","spades"), Card.new("9","hearts")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end

            #no need to test tied triplets, quads in this game variant
            it "ranks 3-of-a-kind by highest kind" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("7","spades"), Card.new("J","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("6","clubs"), Card.new("J","spades"), Card.new("9","hearts")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
            it "ranks 4-of-a-kind by highest kind" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("7","spades"), Card.new("7","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("6","clubs"), Card.new("6","spades"), Card.new("9","hearts")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
        end

        context "2 pair" do 
            it "ranks by highest pair first" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("3","spades"), Card.new("3","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("6","hearts"), Card.new("6","diamonds"), Card.new("5","clubs"), Card.new("5","spades"), Card.new("9","hearts")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
            it "ranks by 2nd highest pair second" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("5","spades"), Card.new("5","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("7","clubs"), Card.new("7","spades"), Card.new("4","clubs"), Card.new("4","spades"), Card.new("9","hearts")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
            it "ranks by 5th card last" do 
                cards = [Card.new("7","hearts"), Card.new("7","diamonds"), Card.new("5","spades"), Card.new("5","clubs"), Card.new("9","diamonds")]
                cards.each {|c| hand.add_card(c)}
                cards2 = [Card.new("7","clubs"), Card.new("7","spades"), Card.new("5","diamonds"), Card.new("5","hearts"), Card.new("8","diamonds")]
                cards2.each {|c| other_hand.add_card(c)}
                expect(hand.wins_against?(other_hand)).to be true
            end
        end 
    end
end
