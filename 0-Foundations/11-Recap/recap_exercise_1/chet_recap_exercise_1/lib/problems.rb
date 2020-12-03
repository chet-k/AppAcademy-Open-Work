# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
    pairs = []
    vowels_reference = {"a" => true, "e" => true, "i" => true, "o" => true, "u" => true}
    
    words.each_with_index do |word_a, i|
        break if i == words.length - 1
        
        other_words = words[i+1..-1]
        vowels_a = vowels_in(word_a)
        
        other_words.each do |word_b|
            vowels_b = vowels_in(word_b)

            if vowels_a.merge(vowels_b) == vowels_reference
                pairs << [word_a, word_b].join(" ") 
            end
        end
    end

    pairs
end

def vowels_in(word) #to use as vowels_in, use a_elements_in_b("aeiou",word)
    vowels = "aeiou"
    vowels_in = {}
    word.each_char {|s| vowels_in[s] = true if vowels.include?(s)}
    vowels_in
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    (2...num).each do |n|
        return true if num % n == 0
    end
    false
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    out = []
    bigrams.each {|gram| out << gram if str.include?(gram)}
    out
end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        #default proc: key is equal to value
        prc ||= Proc.new {|k, v| k == v}
        out = {}

        self.each do |k, v|
            out[k] = v if prc.call(k, v)
        end

        out
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        out = []

        if length
            i = 0
            while i + length-1 < self.length
                out << self[i..i+length-1]
                i += 1
            end
        else
            i = 0
            while i < self.length
                j = i
                while j < self.length
                    out << self[i..j]
                    j += 1
                end
                i += 1
            end
        end

        out
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        alpha = ("a".."z").to_a
        ciphered_indices = []
        ciphered_word = ""

        self.each_char do |char| 
            ciphered_index = (alpha.index(char) + num) % 26
            ciphered_word += alpha[ciphered_index]
        end
        
        ciphered_word
    end
end