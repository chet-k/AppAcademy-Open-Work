def hipsterfy(word)
    vowels = "aeiou"
    i = word.length-1
    while i >= 0 
        if vowels.include?(word[i])
            break
        end
        i -= 1
    end
    
    return word if i == -1
    
    word[0...i] + word[i+1..-1]
end

def vowel_counts(str)
    vowels = "aeiou"
    hash = Hash.new(0)
    str.each_char {|s| hash[s.downcase] += 1 if vowels.include?(s.downcase)}
    hash
end

def caesar_cipher(message, n)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    message_indices = Array.new(message.length)
    new_message = Array.new(message.length)

    # get index of each character, otherwise put the character straight
    #   into the new string
    message.each_char.with_index do |s, i| 
        if alphabet.include?(s)
            message_indices[i] = alphabet.index(s)
        else
            new_message[i] = s
        end
    end
    
    # put chars into new message by index, using (i+n) % 26 to wrap around 
    # the end of the alphabet
    # according to spec, we are only worrying about positive input
    new_message.each_with_index do |char, i|
        new_message[i] = alphabet[(message_indices[i] + n) % alphabet.length] if char == nil 
    end

    new_message.join("")
end