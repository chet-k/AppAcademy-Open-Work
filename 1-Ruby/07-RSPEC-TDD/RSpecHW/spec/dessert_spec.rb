require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:brownie) { Dessert.new("brownie", 10, chef) }

  describe "#initialize" do
    it "sets a type" do 
      expect(brownie.type).to eq("brownie")
    end

    it "sets a quantity" do
      expect(brownie.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(brownie.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("brownie","ten",chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(brownie.ingredients).to_not include("sugar")
      brownie.add_ingredient("sugar")
      expect(brownie.ingredients).to include("sugar")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      brownie.add_ingredient("sugar")
      brownie.add_ingredient("chocolate")
      brownie.mix!
      expect(brownie.ingredients.length).to eq(2)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      brownie.eat(2)
      expect(brownie.quantity).to eq(8)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{brownie.eat(12)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize)
      brownie.serve
      expect(chef).to have_received(:titleize)      
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake)
      brownie.make_more
      expect(chef).to have_received(:bake).with(brownie)
    end
  end
end
