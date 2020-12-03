def select_even_nums(arr)
    new_arr = arr.select(&:even?)
end

def reject_puppies(dogs)
    grown_dogs = dogs.reject { |dog| dog["age"] < 3 }
end

def count_positive_subarrays(arr)
    arr.count { |subarr| subarr.sum > 0 }
end

def aba_translate(word)
    new_word = word.split("").map do |char|
        if "aeiou".include?(char)
            char + "b" + char
        else
            char
        end
    end
    new_word.join("")
end

def aba_array(arr)
    new_arr = arr.map {|word| aba_translate(word)}
end