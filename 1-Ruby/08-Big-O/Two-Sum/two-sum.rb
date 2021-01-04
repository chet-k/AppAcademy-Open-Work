require 'benchmark'
"""
Given an array of unique integers and a target sum, determine whether any 
two integers in the array sum to that amount.
"""

# 1. BRUTE FORCE
# O(N^2) time
# O(1) space
def quadratic_two_sum?(nums, target)
    nums.each do |n1|
        nums.each do |n2|
            next if n1 == n2
            return true if n1 + n2 == target
        end
    end
end

# 2. SORTING
# a sorted array allows us to seek the target with binary search.
# O(N*logN) time to sort, O(N*logN) time to bsearch N times.
# O(N) space (or O(1) if sorting input in place)
def loglinear_two_sum?(nums, target)
    nums_ascending = nums.sort
    
    nums_ascending.each do |n1|
        n2 = bsearch(nums_ascending, target - n1)
        if !n2 || n2 == n1
            next
        elsif n2
            return true
        else
            raise
        end
    end
    false
end

def bsearch(sorted_array, target)
    if sorted_array.length == 0
        nil
    elsif sorted_array.length == 1
        sorted_array[0] == target ? 0 : nil
    else
        idx = sorted_array.length / 2
        pivot = sorted_array[idx]

        if pivot == target
            idx
        elsif pivot > target
            bsearch(sorted_array[0...idx], target)
        elsif pivot < target
            found_at = bsearch(sorted_array[idx+1..-1], target)
            found_at ? found_at + idx + 1 : nil
        end
    end
end

# 3. HASH MAP
# first pass: map of (value) index of seen number to (key) number that would sum to target
# second pass: search thru array for number that is a key in hash
def linear_two_sum?(nums, target)
    h = Hash.new
    nums.each { |n| h[target-n] = n }
    nums.any? { |n| h[n] }
end


# BENCHMARKING
if __FILE__ == $PROGRAM_NAME
    
    tests = [10, 100, 1000, 10000, 100000]
    averages = 10
    
    puts "EACH METHOD REPEATED #{averages} times:" 
    Benchmark.bm( 30 ) do |bm|  # The 20 is the width of the first column in the output.
        
        tests.each do |len| 
            
            arr = [*1..len*100].sample(len) 
            target = arr.sample(2).sum

            if len <= 10000
                bm.report( "#{len} elements, brute force:" ) do 
                    averages.times do 
                        target = arr.sample(2).sum
                        quadratic_two_sum?(arr, target)
                    end
                end
            else
                puts "#{len} elements, brute force:    --------   --------   -------- (  --------)"
            end

            bm.report( "#{len} elements, sorted:" ) do 
                averages.times do 
                    target = arr.sample(2).sum
                    loglinear_two_sum?(arr, target)
                end
            end

            bm.report( "#{len} elements, hash map:" ) do 
                averages.times do 
                    target = arr.sample(2).sum
                    linear_two_sum?(arr, target)
                end
            end
            puts "----"
        end
        puts "benchmark finished"
    end
end