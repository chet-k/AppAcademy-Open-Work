"""
NAIVE SOLUTION

total execution time:
O(N^2) +  O(N^2 * N) 

-> O(N^3) time
"""

def cubic_time(list)
    subarrays = array_of_subarrays(list)      # O(N^2) operation
    largest = list[0]
    
    subarrays.each do |sub|                   # O(N^2) iterations. length of subarrays is roughly (N^2 / 2)
        subsum = sub.sum                      # O(N) operation (worst case): sub is same length as input
        largest = subsum if subsum > largest
    end
    largest
end

def array_of_subarrays(list)                
    out = []
    (0...list.length).each do |i1|          # O(N) operation: entire length of input array
        (i1...list.length).each do |i2|     # O(N) operation worst case: entire length of input array
            out << list[i1..i2]             # constant operation: assignment
        end
    end
    out
end



"""
LINEAR SOLUTION

- if >= 0: keep adding to sub-sum
- if < 0: reset sub-sum. No subarray to the left will increase the max sum.
- update max after each step
"""

def linear_time(list)
    current_subsum = 0
    max_subsum = list[0]
    
    list.each do |el|
        current_subsum += el
        max_subsum = current_subsum if current_subsum > max_subsum
        current_subsum = 0 if current_subsum < 0 
    end

    max_subsum
end


test1 = [5, 3, -7]              # => 8  (from [5, 3])
test2 = [2, 3, -6, 7, -6, 7]    # => 8  (from [7, -6, 7])
test3 = [-5, -1, -3]            # => -1 (from [-1])

puts "\n\n\nCUBIC SOLUTION"
puts "output: #{cubic_time(test1)}\ncorrect: 8\n\n"
puts "output: #{cubic_time(test2)}\ncorrect: 8\n\n"
puts "output: #{cubic_time(test3)}\ncorrect: -1\n\n"
puts "\n\n"

puts "\n\n\nLINEAR SOLUTION"
puts "output: #{linear_time(test1)}\ncorrect: 8\n\n"
puts "output: #{linear_time(test2)}\ncorrect: 8\n\n"
puts "output: #{linear_time(test3)}\ncorrect: -1\n\n"
puts "\n\n"
