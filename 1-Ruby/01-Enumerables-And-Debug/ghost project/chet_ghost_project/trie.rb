#based on https://www.rubyguides.com/2017/11/prefix-trees-in-ruby/
#with additional include_prefix? method intended for use in Ghost game.

class Node
    attr_reader :value, :next
    attr_accessor :word

    def initialize(value)
        @value = value

        @word = false
        @next = []
    end
end

class Trie
    def initialize
        @root = Node.new("*")
    end

    def add_word(word)
        letters = word.chars
        node = @root

        letters.each {|letter| node = add_character(letter, node.next)}
        
        node.word = true
    end

    def find_word(word)
        letters = word.chars
        node = @root
        word_found = letters.all?{|letter| node = find_character(letter, node.next)}

        yield word_found, node if block_given?
        
        node
    end

    def add_character(character, trie_node)
        trie_node.find {|n| n.value == character} || add_node(character, trie_node)
    end

    def find_character(character, trie_node)
        trie_node.find {|n| n.value == character}
    end

    def add_node(character, trie_node)
        Node.new(character).tap {|new_node| trie_node << new_node}
    end

    def include_word?(word)
        find_word(word) {|found, node| return found && node.word}
    end

    def include_prefix?(prefix)
        find_word(prefix) {|found, node| return found}
    end
end

# testing code
# if __FILE__ == $PROGRAM_NAME
#     trie = Trie.new
#     trie.add_word("cat")
#     trie.add_word("cap")
#     trie.add_word("cape")
#     trie.add_word("camp")

#     p trie.include_word?("cape")
#     p trie.include_word?("ca")
#     p trie.include_prefix?("ca")

# end
