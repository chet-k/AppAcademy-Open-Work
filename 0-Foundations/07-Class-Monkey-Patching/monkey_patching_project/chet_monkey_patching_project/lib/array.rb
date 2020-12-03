# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        return nil if self.length == 0
        self.max - self.min
    end

    def average
        return nil if self.length == 0
        1.0 * self.sum / self.length
    end

    def median
        sorted_temp = self.sort
        n = self.length
        if n == 0
            return nil 
        elsif n.even?
            return 1.0 * (sorted_temp[n/2 - 1] + sorted_temp[n/2]) / 2
        else
            return sorted_temp[n/2]
        end
    end

    def counts
        hash = Hash.new(0)
        self.each {|ele| hash[ele] += 1}
        hash
    end

    def my_count(val)
        val_count = 0
        self.each{|ele| val_count += 1 if ele == val}
        val_count
    end

    def my_index(val)
        self.each_with_index{|ele, i| return i if ele == val}
        nil
    end

    def my_uniq
        # uniques = []
        # ele_counts = self.counts
        # ele_counts.each {|key, val| uniques << key} # wait a minute...
        # uniques
        self.counts.keys # works because Ruby hashes preserve input order
    end

    def my_transpose
        new_arr = Array.new(self.length) { Array.new(self[0].length) }
        self.each_with_index do |row, m|
            row.each_with_index do |ele, n|
                new_arr[n][m] = ele
            end
        end
        new_arr
    end



  
end
