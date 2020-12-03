def all_words_capitalized?(arr) # won't work when word.length < 2
    arr.all? { |word| word == word[0].upcase + word[1..-1].downcase}
end

def no_valid_url?(arr)
    arr.none? {|url| url.end_with?(".com",".net",".io",".org")}
end

def any_passing_students?(students)
   students.any? {|student| mean(student[:grades]) >= 75} 
end

def mean(arr)
    arr.sum / (1.0 * arr.length)
end