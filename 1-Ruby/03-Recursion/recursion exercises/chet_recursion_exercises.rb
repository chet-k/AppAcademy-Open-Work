require "byebug"

def range(n1, n2) # identical to (n1...n2).to_a
    return [] if n2 <= n1
    [n1] + range(n1+1, n2)
end
# p range(1,5)
# p range(6,12)
# p range(-6,-2)
# p range(3,3)
# p range(8,3)

def sum_arr_rec(arr)
    return 0 if arr.length == 0
    return arr[0] if arr.length == 1
    arr[0] + sum_arr_rec(arr[1..-1])
end

def sum_arr_iter(arr)
    arr.inject{|ele, sum| sum + ele}
end
# p sum_arr_rec([1, 9, 3, 6, 5, 2, 7])
# p sum_arr_iter([1, 9, 3, 6, 5, 2, 7])
# p sum_arr_rec([3])
# p sum_arr_iter([3])
# p sum_arr_rec([1, 9])
# p sum_arr_iter([1, 9])

def exp1(b, n)
    n == 0 ? 1 : b * exp1(b, n - 1)
end

def exp2(b,n)
    if n == 0
        1
    elsif n == 1
        b
    elsif n.even?
        exp2(b, n / 2) * exp2(b, n / 2)
    else
        b * exp2(b, (n - 1) / 2) * exp2(b, (n - 1) / 2)
    end
end

# puts "method 1"
# p exp1(1,0)
# p exp1(1,1)
# p exp1(1,2)
# p exp1(2,0)
# p exp1(2,1)
# p exp1(2,2)
# p exp1(2,3)
# p exp1(3,2)
# puts "method 2"
# p exp2(1,0)
# p exp2(1,1)
# p exp2(1,2)
# p exp2(2,0)
# p exp2(2,1)
# p exp2(2,2)
# p exp2(2,3)
# p exp2(3,2)

class Array
    def deep_dup #for nested Arrays only, no other data types
        copy = []
        self.each do |ele|
            if ele.is_a?(Array)
                copy << ele.deep_dup
            else
                copy << ele.dup
            end
        end
        copy
    end
end


def fib(n)
    if n < 0
        nil
    elsif n == 0
        [0]
    elsif n == 1
        [0, 1]
    else
        prev_fib = fib(n-1)
        prev_fib + [prev_fib[-1] + prev_fib[-2]]
    end
end
# p fib(-1)   # nil
# p fib(0)    # [0]
# p fib(1)    # [0, 1]
# p fib(2)    # [0, 1, 1]
# p fib(3)    # [0, 1, 1, 2]
# p fib(14)   # [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]


def bsearch(sorted_array, target)
    return nil if sorted_array.empty?
    
    i_mid = (sorted_array.length-1) / 2
    mid = sorted_array[i_mid]
    
    if target == mid
        i = i_mid
    elsif target < mid
        i = bsearch(sorted_array[0...i_mid], target)
    else
        i = bsearch(sorted_array[i_mid + 1..-1], target)
        i += mid + 1 if i
    end
    
    i
end
# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(arr)
    return arr if arr.length <= 1
    
    mid = arr.length / 2
    left, right = arr[0...mid], arr[mid..-1]
    left, right = merge_sort(left), merge_sort(right)

    merge(left, right)
end

def merge(arr1, arr2)
    merged = []
    el1, el2 = arr1.shift, arr2.shift
    until !(el1 || el2)
        if el1 && !el2
            merged << el1
            el1 = nil
        elsif el2 && !el1
            merged << el2
            el2 = nil
        elsif el1 <= el2
            merged << el1
            el1 = nil
        else #el1 > el2
            merged << el2
            el2 = nil
        end
        el1 = arr1.shift unless el1
        el2 = arr2.shift unless el2
    end
    merged
end
# test_mergesort_arr = (1..100).to_a.shuffle
# puts test_mergesort_arr
# puts "--------"
# puts merge_sort(test_mergesort_arr)

def subsets(arr)
    return [arr] if arr.empty?
    out = []
    subsets(arr[1..-1]).each do |s|
        out << s
        out << [arr[0]] + s
    end
    out
end
# puts subsets([1,2,3])

def permutations(arr)
    return [] if !arr 
    return [arr] if arr.length <= 1
    out = []
    
    arr.each_with_index do |ele, i|
        subarray_perms = permutations(arr[0...i] + arr[i+1..-1])
        # debugger
        subarray_perms.each {|sp| out << [ele] + sp}
    end
    out
end
# puts permutations([1,2,3])
# puts [1,2,3,4,5].permutation.to_a == permutations([1,2,3,4,5])

def greedy_make_change(amount, coins = [25, 10, 5, 1])
    return [] if amount == 0
    change = []
    sorted_coins = coins.sort
    largest_coin = sorted_coins.pop

    large_coins = amount / largest_coin
    large_coins.times {change << largest_coin}

    new_amount = amount - change.sum
    
    change += greedy_make_change(new_amount, sorted_coins)

    change
end

def make_better_change(amount, coins = [25, 10, 5, 1])
    return [] if amount == 0 || coins.empty?
    change = []
    sorted_coins = coins.sort.reverse

    sorted_coins.each_with_index do |coin, i|
        new_amount = amount - coin
        if new_amount >= 0
            change << [coin] + make_better_change(new_amount, coins[i..-1])
        end
    end

    # return shortest array in change
    # grabbed online: how does this work??
    # also given without explanation in the ruby doc
    change.min {|x,y| x.length <=> y.length}
end
puts "greedy_make_change(32)"
p greedy_make_change(32)
puts "greedy_make_change(24, [10,7,1])"
p greedy_make_change(24, [10,7,1])
puts "make_better_change(32)"
p make_better_change(32)
puts "make_better_change(24, [10,7,1])"
p make_better_change(24, [10,7,1])
