def palindrome?(str)
    left = 0
    right = str.length-1
    while left <= right
        return false if str[left] != str[right]
        left += 1
        right -= 1
    end
    true
end

def substrings(str)
    subs = []
    (0...str.length).each do |i1|
        (i1...str.length).each do |i2|
            subs << str[i1..i2]
        end
    end
    subs
end

def palindrome_substrings(str)
    palindrome_subs = substrings(str)
    palindrome_subs.select!{|substr| substr.length > 1 && palindrome?(substr) }
end