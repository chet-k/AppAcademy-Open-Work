def average(n1, n2)
    (n1 + n2) / 2.0
end

def average_array(arr)
    arr.sum / arr.length.to_f
end

def repeat(str, n)
    out = ""
    n.times {out += str}
    out
end

def yell(str)
    str.upcase + "!"
end

def alternating_case(sentence)
    words = sentence.split(" ")
    caps = true #start with caps word
    words.each_with_index do |word, i| 
        if caps
            words[i] = word.upcase
        else
            words[i] = word.downcase
        end
        caps = !caps
    end

    words.join(" ")
end

#p alternating_case("code never lies, comments sometimes do")