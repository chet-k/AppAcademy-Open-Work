def partition(array, num)
    less_than = []
    greater_than = []

    array.each do |n|
        if n < num
            less_than << n
        elsif n >= num
            greater_than << n
        end
    end
    
    [less_than, greater_than]
end

def merge(hash1, hash2)
    new_hash = {}
    # #begin merge with hash2, since that is the default if they have duplicate keys
    hash2.each {|k, v| new_hash[k] = v}
    hash1.each {|k, v| new_hash[k] = v if !new_hash.has_key?(k)}
    new_hash
end

def censor(sentence, bad_words)
    # spec says not to worry about punctuation
    vowels = "aeiou"
    new_sentence = sentence.split(" ")
    new_sentence.map! do |word|
        if bad_words.include? word.downcase
            #p censor_word(word)
            word = censor_word(word)
        else
            word
        end
    end

    new_sentence.join(" ")
end

def censor_word(word)
    vowels = "aeiou"
    new_word = word.split("").map do |char|
        if vowels.include?(char.downcase)
            new_char = "*" 
        else
            char
        end
    end
    new_word.join("")
end

def power_of_two?(n)
    powers = 1
    while powers < n
        powers *= 2
    end
    return powers == n
end