require 'rspec'
require 'array_tdd'

describe Array do
    context "#my_uniq" do
        subject(:arr) {[6,6,7,12,3,7,7,4,4,5,1,2,3,4,3,4,5,1] }
        let (:uniques) { arr.my_uniq }
        it "returns unique elements" do
            expect(uniques.all? {|el| uniques.count(el) == 1}).to be true
        end
        it "returns elements in the order they appear"  do
            expect(arr.index(uniques[0]) < arr.index(uniques[1])).to be true
        end
    end

    context "#two_sum" do
        subject(:arr) { [-1, 0, 1, 2, -2, 1] }
        let(:pairs) { arr.two_sum }
        it "returns all pairs of indices whose elements sum to zero" do
            expect(pairs).to eq([[0, 2], [0, 5], [3, 4]])
        end
        it "pairs are sorted dictionary-wise" do
            expect(pairs[0][0] < pairs[0][1]).to be true
        end
    end

    context "#my_transpose" do 
        it "transposes rows to columns" do 
            expect([[0, 1, 2],[3, 4, 5],[6, 7, 8]].my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]]) 
        end

        it "raises a TypeError for 1D arrays" do 
            expect{[0,1,2,3].my_transpose}.to raise_error(TypeError)
        end

        it "raises an IndexError if the length of subarrays don't match" do 
            expect {[[0, 1, 2],[3, 4, 5, 6]].my_transpose}.to raise_error(IndexError)
        end
    end

    #Write a method that takes an array of stock prices 
    #(prices on days 0, 1, ...), and outputs the most profitable pair of days 
    #on which to first buy the stock and then sell the stock. 
    #Remember, you can't sell stock before you buy it!
    context "#stock_picker" do
        it "raises an error if input is not 1D integer array" do
            expect {[[1,2,3],[3,4], "alsjdhf"].stock_picker}.to raise_error("1D integer input required")
        end

        it "returns 0 if history is less than 2 days" do
            expect([1].stock_picker).to eq(0)
        end 

        it "outputs the most profitable pair of days, buying before selling" do
            expect([1, 2, 3, 4, 5, 6].stock_picker).to eq(5)
            expect([3, 2, 1, 4, 5, 6].stock_picker).to eq(5)
            expect([6, 5, 4, 3, 2, 1].stock_picker).to eq(0)
            expect([3, 20, 1, 2, 12, 6].stock_picker).to eq(17)
        end
    end

    
end