# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    return str if str.length == 0

    compressed = ""
    cur_char = str[0] # required for if/elsif/else logic
    consecutive_count = 0

    str.each_char do |char| 
        if char == cur_char
            consecutive_count += 1
        elsif consecutive_count == 1
            compressed += cur_char
            cur_char = char
            # consecutive_count = 1  # already implied
        else
            compressed += consecutive_count.to_s + cur_char
            cur_char = char
            consecutive_count = 1
        end
        
    end

    if consecutive_count == 1
        compressed += cur_char
    else
        compressed += consecutive_count.to_s + cur_char
    end

    compressed
end


p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"