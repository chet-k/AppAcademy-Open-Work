# Debug this code to pass rspec! There are 2 mistakes to fix.

# Write a method, titleize, that accepts a string representing a title 
# and capitalizes each word in a string except 'a', 'and', 'of', 'on', or 'the'.
# The first word of the title should be capitalized no matter what.

require "byebug"



def titleize(title)
  little_words = [ "and", "the", "over", "a", "on", "of" ]
  #debugger
  words = title.split(" ")

  titleized_words = words.map.with_index do |word, i|
    if i == 0 || !little_words.include?(word)
      if word.length > 1
        word[0].upcase + word[1..-1].downcase
      else
        word.upcase
      end
    else
      word.downcase
    end
  end

  titleized_words.join(" ")
end
