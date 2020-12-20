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

    def my_transpose
        if !self[0].is_a? Array
            raise TypeError.new("2D Array required")
        elsif self.any? {|subarr| subarr.length != self[0].length}
            raise IndexError.new("subarray lengths do not match")
        end

        out =  Array.new(self[0].length) {Array.new(self.length)}

        (0...self.length).each do |m|
            (0...self[0].length).each do |n|
                out[n][m] = self[m][n]
            end
        end

        out
    end
end