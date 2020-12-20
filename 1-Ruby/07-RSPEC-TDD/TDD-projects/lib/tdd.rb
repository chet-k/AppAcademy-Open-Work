class Array
    def my_uniq
        Set.new(self).to_a
    end

    def two_sum
        out = []
        
        element_indices = Hash.new { |h, k| h[k] = [] }
        self.each_with_index { |el, i| element_indices[-el] << i }

        self.each_with_index do |el, i1| 
            element_indices[el].each {|i2| out << [i1, i2] if i1 < i2}
        end

        out
    end
end