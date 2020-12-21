require 'rspec'
require 'towers_tdd'

describe Towers_Game do
    let(:game_size) {5}
    subject(:game) {Towers_Game.new(game_size)}
    
    describe "#initialize" do 
        it "creates 3 towers" do 
            expect(game.towers.length).to eq(3)
        end

        it "sets game size by input" do
            expect(game.size).to eq(game_size)
        end

        it "stacks all disks on the first tower, equal to game_size" do 
            expect(game[0].length).to eq(game_size)
            expect(game[1].length).to eq(0)
            expect(game[2].length).to eq(0)
        end

        it "initializes with minimum size of 3" do
            small_game = Towers_Game.new(2)
            expect(small_game[0].length).to eq(3)
        end
    end
    
    describe "#move" do
        before(:example) {game.move(0,1)}
        it "removes the top disk from the first pile" do     
            expect(game[0].length).to eq(game_size-1)
        end
        it "adds that disk to the top of the second pile" do
            expect(game[1].length).to eq(1)
        end
    end

    describe "#valid_move?" do
        before(:example) do 
            game.move(0,1)
            game.move(0,2)
            game.move(1,2)
        end
        it "returns false if start has no disks" do 
            expect(game.valid_move?(1,2)).to be false
        end
        it "returns true if start has disks and finish is empty" do 
            expect(game.valid_move?(0,1)).to be true
        end
        it "returns false if start has disks and and top disk is larger than top disk on finish" do
            expect(game.valid_move?(0,2)).to be false
        end
        it "returns false if start == finish" do
            expect(game.valid_move?(1,1)).to be false
        end
    end
    
    describe "#won?" do
        short_game = Towers_Game.new
        short_game.move(0,2)
        short_game.move(0,1)
        short_game.move(2,1)
        short_game.move(0,2)
        short_game.move(1,0)
        short_game.move(1,2)

        it "returns false if any disks remain in first 2 towers" do
            expect(short_game.won?).to be false
        end
        it "returns true only when all disks have been moved to the third tower" do 
            short_game.move(0,2)
            expect(short_game.won?).to be true
        end
    end
end