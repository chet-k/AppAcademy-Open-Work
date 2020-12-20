require 'rspec'
require 'towers_tdd'

describe Towers_Game do
    describe "#move" do
        it "removes the top disk from the first pile"
        it "adds that disk to the top of the second pile"
    end

    describe "#won?" do
        it "returns true only when all disks have been moved to the third tower"
    end
end