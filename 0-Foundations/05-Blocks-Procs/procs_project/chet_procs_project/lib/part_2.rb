def reverser(str, &prc)
    prc.call(str.reverse)
end

def word_changer(sentence, &prc)
    new_sentence = []
    sentence.split(" ").each { |word| new_sentence << prc.call(word) }
    new_sentence.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    [prc1.call(num), prc2.call(num)].max
end

def and_selector(arr, proc1, proc2)
    new_array = []
    arr.each { |ele| new_array << ele if proc1.call(ele) && proc2.call(ele) }
    new_array
end

def alternating_mapper(arr, prc_even_indices, prc_odd_indices)
    new_array = []
    arr.each_with_index do |ele, i|
        if i.even? 
            new_array << prc_even_indices.call(ele)
        else
            new_array << prc_odd_indices.call(ele)
        end
    end
    new_array
end