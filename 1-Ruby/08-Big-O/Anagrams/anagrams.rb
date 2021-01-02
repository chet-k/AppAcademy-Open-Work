require 'benchmark'

"""
METHOD I
Generate and store all possible anagrams of str1, then check if str2 is one.

Finding all permutations takes O(N!) time. 
Storing them all requires O(N!) memory.
"""
def first_anagram?(str1, str2)
    return false unless str1.length == str2.length
    all_anagrams = str1.split("").permutation.to_a.map! {|arr| arr.join}
    all_anagrams.include?(str2)
end


"""
METHOD II
Iterate through str1, and delete matching character in str2 until
either both strings are empty or a character cannot be found.

Iterate through each character => O(N)
Then on each iteration, linear search through other string => O(N)

Time complexity O(N^2)

Space complexity: O(N) if we include storing str2 as an array.
Or O(1) space if we are only considering operations in the loop.
"""
def second_anagram?(str1, str2)
    return false unless str1.length == str2.length
    arr2 = str2.split("")
    
    str1.each_char do |c|
        i2 = arr2.index(c)
        return false unless i2
        arr2.delete_at(i2)
    end
    true
end

"""
METHOD III
Check if sorted strings are identical

Sort time complexity: O(N * log(N))
Space complexity: O(1) if sorted in place
"""
def third_anagram?(str1, str2)
    return false unless str1.length == str2.length
    str1.split("").sort! == str2.split("").sort!
end


"""
METHOD IV
count character occurences in hashes.
check equality of resulting hashes.

create hash: O(N) time / O(N) space
check equality: O(N) time / O(1) space
"""
def fourth_anagram?(str1, str2)
    return false unless str1.length == str2.length
    h1 = Hash.new { |h, k| h[k] = 0 }
    h2 = Hash.new { |h, k| h[k] = 0 }

    (0..str1.length).each do |i|
        h1[str1[i]] += 1
        h2[str2[i]] += 1
    end
    
    h1 == h2
end

"""
METHOD IV BONUS
count character occurences in one hash.
increment count for chars in str1 / decrement for chars in str2
final hash should have all-zero values

create hash: O(N) time / O(N) space
check equality: O(N) time / O(1) space
"""
def fourth_bonus_anagram?(str1, str2)
    return false unless str1.length == str2.length
    counts = Hash.new { |h, k| h[k] = 0 }

    (0..str1.length).each do |i|
        counts[str1[i]] += 1
        counts[str2[i]] -= 1
    end
    
    counts.values.all? {|v| v == 0}
end


# BENCHMARKING
if __FILE__ == $PROGRAM_NAME
    short_test1 = "restful"
    short_test2 = "fluster"

    long_str_length = 100000
    long_str1 = (0...long_str_length).map { ('a'..'z').to_a[rand(26)] }.join
    long_str2 = long_str1.split("").shuffle.join("")

    puts "\n\n\n----"
    Benchmark.bm( 28 ) do |bm|  # The 20 is the width of the first column in the output.
        bm.report( "Method 1 str length #{short_test1.length}:" ) do 
        first_anagram?(short_test1, short_test2)
        end
    
        bm.report( "Method 2 str length #{short_test1.length}:" ) do
        second_anagram?(short_test1, short_test2)
        end

        bm.report( "Method 3 str length #{short_test1.length}:" ) do
        third_anagram?(short_test1, short_test2)
        end

        bm.report( "Method 4 str length #{short_test1.length}:" ) do
        fourth_anagram?(short_test1, short_test2)
        end

        puts "\n----\n\n"

        bm.report( "Method 2 str length #{long_str_length}:" ) do
        second_anagram?(long_str1,long_str2)
        end

        bm.report( "Method 3 str length #{long_str_length}:" ) do
        third_anagram?(long_str1,long_str2)
        end

        bm.report( "Method 4 str length #{long_str_length}:" ) do
        fourth_anagram?(long_str1,long_str2)
        end

        bm.report( "Method 4.1 str length #{long_str_length}:" ) do
        fourth_bonus_anagram?(long_str1,long_str2)
        end
    end
end