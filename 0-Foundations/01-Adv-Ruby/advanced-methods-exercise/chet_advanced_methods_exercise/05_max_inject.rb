# Write a method, max_inject(arr), that accepts any amount of numbers arguments and returns
# the largest number. Solve this using the built-in inject.

def max_inject(*nums)   
    return nil if nums.length == 0
    
    nums.inject do |cur_max, n|
        if n > cur_max
            n
        else
            cur_max
        end
    end
end

# p max_inject()                # => nil
p max_inject(1, -4, 0, 7, 5)  # => 7
p max_inject(30, 28, 18)      # => 30
