# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"

def largest_prime_factor(n)
    (2..n).reverse_each { |num| return num if n % num == 0 && prime?(num) }
end

def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    true
end

def unique_chars?(word)
    counts = Hash.new(0)
    word.each_char do |char|
        counts[char] += 1
        return false if counts[char] > 1
    end
    true
end

def dupe_indices(arr)
    indices = Hash.new { |h, k| h[k] = [] } 
    arr.each_with_index { |ele, i| indices[ele].push(i) }
    indices.select! { |k, v| v.length > 1 }
end

def ana_array(arr1, arr2)
    return false if arr1.length != arr2.length
    
    hash1 = arr_to_hash_counts(arr1)
    hash2 = arr_to_hash_counts(arr2)

    hash1 == hash2
end

def arr_to_hash_counts(arr)
    hash = Hash.new(0)
    arr.each {|ele| hash[ele] += 1}
    hash
end