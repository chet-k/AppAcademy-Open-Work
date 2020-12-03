require "byebug"

##### GENERAL PROBLEMS #####
def no_dupes?(arr)
    #returns new array containing elements which were not repeated
    out = []
    counts = Hash.new(0)
    arr.each {|ele| counts[ele] += 1}
    counts.each {|k,v| out << k if v == 1}
    out
end
# no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# no_dupes?([true, true, true])            # => []


def no_consecutive_repeats?(arr)
    (1...arr.length).each {|i| return false if arr[i] == arr[i-1]}
    true
end
# no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# no_consecutive_repeats?(['x'])                              # => true


def longest_streak(str)
    return str if str.length < 2
    
    max_streak = ""
    i = 0
    j = 1
    while i < str.length - 1
        j = i + 1
        cur_streak = ""
        while j < str.length && str[i] == str [j]
            j += 1
        end

        cur_streak = str[i...j]
        max_streak = cur_streak if cur_streak.length >= max_streak.length

        i = j
    end
    
    return str[-1] if max_streak.length == 1
    max_streak
end
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'


def bi_prime?(num)
    prime_factor_candidates = (2...num).to_a.select {|n| num % n == 0}
    prime_factors = prime_factor_candidates.select {|n| prime?(n)}
    prime_factors.each {|n| return true if prime_factors.include?(1.0*num/n)}
    false
end

def prime?(num)
    (2...num).each {|n| return false if num % n == 0}
    true
end
# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false


def vigenere_cipher(message, keys)
    alphabet = ("a".."z").to_a
    indices = message.split("").map {|char| alphabet.index(char)}
    
    ciphered_message = ""
    indices.each_with_index do |n, i|
        shift_amount = keys[i % keys.length]
        new_index = (n + shift_amount) % alphabet.length
        ciphered_message += alphabet[new_index]
    end

    ciphered_message
end
# vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# vigenere_cipher("yawn", [5, 1])             # => "dbbo"


def vowel_rotate(str)
    rotated_word = ""
    vowels = "aeiou"
    
    last_vowel = ""
    i = str.length - 1
    while i >= 0
        if vowels.include?(str[i])
            last_vowel = str[i] 
            break
        end
        i -= 1
    end
    
    str.each_char do |char|
        if vowels.include?(char)
            rotated_word += last_vowel
            last_vowel = char
        else
            rotated_word += char
        end
    end

    rotated_word
end
# vowel_rotate('computer')      # => "cempotur"
# vowel_rotate('oranges')       # => "erongas"
# vowel_rotate('headphones')    # => "heedphanos"
# vowel_rotate('bootcamp')      # => "baotcomp"
# vowel_rotate('awesome')       # => "ewasemo"




##### PROC PROBLEMS #####
class String
    def select(&prc)
        return "" if !prc
        selected_chars = ""
        self.each_char {|char| selected_chars += char if prc.call(char)}
        selected_chars
    end

    def map!(&prc)
        self.each_char.with_index {|char, i| self[i] = prc.call(char, i)}
    end
end
# # String#select Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""
#
#
# String#map! Examples
# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"
#
# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"




##### RECURSION PROBLEMS #####
def multiply(a,b)
    if a == 0 || b == 0
        0
    elsif a >0 && b > 0
        a + multiply(a, b-1)
    elsif a < 0 && b < 0
        -a + multiply(-a, -b-1)
    elsif a < 0
        -(-a + multiply(-a, b-1))
    elsif b < 0
        -(a + multiply(a, -b-1))
    end
end
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(n)
    if n == 0
        []
    elsif n == 1
        [2]
    elsif n == 2
        [2, 1]
    else
        seq = lucas_sequence(n-1)
        seq << seq[-1] + seq[-2]
    end
end
# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    return [num] if prime?(num)

    #otherwise break up into two factors, 
    #and call prime_factorization on them both
    (2..num/2).each do |n| 
        if num % n == 0
            return prime_factorization(n) + prime_factorization(num/n) 
        end
    end
end
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]