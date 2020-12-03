class Array
    def my_each(&prc)
        # takes a block, 
        # calls the block on every element of the array, 
        # and returns the original array. 
        prc ||= Proc.new {|element| element} 
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        #takes a block
        #returns new array containing only elements that satisfy the block.
        prc ||= Proc.new {|element| element} 
        selected_elements = []
        self.my_each do |ele|
            selected_elements << ele if prc.call(ele)
        end
        selected_elements
    end

    def my_reject(&prc)
        #takes a block
        #returns new array EXCLUDING elements that satisfy the block.
        prc ||= Proc.new {|element| element} 
        selected_elements = []
        self.my_each do |ele|
            selected_elements << ele if !prc.call(ele)
        end
        selected_elements
    end

    def my_any?(&prc)
        self.my_each {|ele| return true if prc.call(ele)}
        false
    end
    
    def my_all?(&prc)
        self.my_each {|ele| return false if prc.call(ele)}
        true
    end

    def my_flatten
        flattened = []
        self.my_each do |ele|
            if ele.is_a? Array
                flattened += ele.my_flatten
            else
                flattened << ele
            end
        end
        flattened
    end

    def my_zip(*arrays)
        zipped = Array.new(self.length) {Array.new}
        self.each_with_index {|ele, i| zipped[i] << ele}
        
        arrays.each do |arr|
            (0...self.length).each do |i|
                zipped[i] << arr[i]
            end
        end

        zipped
    end

    def my_rotate(rotations = 1)
        rotations = rotations % self.length
        if rotations >= 0
            self[rotations..-1] + self[0...rotations]
        else
            self[0...rotations] + self[rotations..-1]
        end
    end

    def my_join(delimiter = "")
        joined_str = ""
        self.each {|ele| joined_str += ele.to_s + delimiter}
        joined_str
    end

    def my_reverse
        reversed_arr = []
        i = self.length-1
        while i >= 0
            reversed_arr << self[i]
            i -=1
        end

        reversed_arr
    end
end

# # my_each test code
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
#
# # my_select test code
# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []
#
# # my_reject test code
# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]
#
# # my_any and my_all test code
# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true
#
# # my_flatten test
# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
#
# # my_zip test
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
# 
# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
#
#
# my_rotate test
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
#
#
# # my_join test code
# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"
#
#
# # my_reverse test code
# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]
