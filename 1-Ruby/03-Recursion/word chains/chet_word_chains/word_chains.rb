require "byebug"
require "set"

class WordChainer
    def initialize(dictionary_file_name)
        file = File.open(dictionary_file_name)
        @dictionary = file.readlines.map(&:chomp).to_set
        file.close
        @current_words = nil
        @all_seen_words = nil
    end
    
    def adjacent_words(word)
        alphabet = ("a".."z").to_a
        one_letter_different = []
        word.each_char.with_index do |char, i|
            alphabet.each do |letter|
                next if letter == char
                new_word = word[0...i] + letter + word[i+1..-1]
                one_letter_different << new_word if @dictionary.include?(new_word)
            end
        end
        one_letter_different
    end

    def run(source, target)
        @current_words = Set.new
        @current_words.add(source)

        @all_seen_words = {source => nil}

        until @current_words.empty? || @all_seen_words.include?(target)
            explore_current_words
        end

        build_path(target)
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adj = adjacent_words(current_word)
            adj.each do |adjacent_word|
                next if @all_seen_words.include?(adjacent_word)
                new_current_words << adjacent_word
                @all_seen_words[adjacent_word] = current_word
            end
        end
        # puts "current words:"
        # new_current_words.each {|word| puts @all_seen_words[word]}
        @current_words = new_current_words 
    end

    def build_path(target)
        backtrack = target
        path = []
        while backtrack
            path << backtrack
            backtrack = @all_seen_words[backtrack]
        end

        path.reverse
    end
end


if __FILE__ == $PROGRAM_NAME
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    wc = WordChainer.new("./dictionary.txt")
    # puts wc.adjacent_words("cat")
    path = wc.run("ping","belt")
    puts "PATH: \n#{path}"
    
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting
    puts "executed in #{elapsed.round(5)} seconds"
end