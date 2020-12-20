require 'rspec'
require 'tdd'

describe Array do
    describe
    subject(:arr) {[6,6,7,12,3,7,7,4,4,5,1,2,3,4,3,4,5,1]}
    context "#my_uniq" do
        let (:uniques) { arr.my_uniq }
        it "returns unique elements" do
            expect(uniques.all? {|el| uniques.count(el) == 1}).to be true
        end
        it "returns elements in the order they appear"  do
            expect(arr.index(uniques[0]) < arr.index(uniques[1])).to be true
        end
    end
end