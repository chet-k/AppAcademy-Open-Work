require "byebug"

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

    def stock_picker
        #O(N) implementation
        raise("1D integer input required") unless self.all?{|el| el.is_a? Integer}
        return 0 if self.length < 2

        future_max = 0
        future_peaks = []
        self.reverse_each do |price|
            future_max = price if price > future_max
            future_peaks << future_max
        end
        future_peaks.reverse!

        max_profit = 0
        self[0...-1].each_with_index do |buy_price, day|
            current_best_sell_price = future_peaks[day+1]
            profit = current_best_sell_price - buy_price
            max_profit = [profit, max_profit].max
        end

        max_profit
    end
end