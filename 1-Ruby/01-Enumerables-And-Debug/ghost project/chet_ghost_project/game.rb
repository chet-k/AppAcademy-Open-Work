# # alternative code to put the dictionary into a Set instead:
# require "set"
# file = File.open("dictionary.txt")
# @dictionary = file.readlines.map(&:chomp).to_set
# file.close
require "byebug"
require_relative "player"
require_relative "trie"

class Game
    ALPHABET = ("a".."z").to_a
    GHOST = "GHOST"

    def initialize(*player_names)
        @fragment = ""
        
        @players = []
        player_names.each {|name| @players << Player.new(name)}
        
        @dictionary = Trie.new
        File.foreach("dictionary.txt") {|line| @dictionary.add_word(line.chomp)}

        @player_number = 0
    end

    def run
        display_standings
        until @players.length == 1
            play_round
            display_standings
            out?(previous_player)
        end

        puts "\n\n\nCONGRATULATIONS, #{current_player.name.upcase}, YOU WON!!\n\n\n"
    end

    def play_round
        until @dictionary.include_word?(@fragment)
            take_turn(current_player)
            next_player!
        end
        
        puts "\n\n#{@fragment.upcase} is a full word!"
        puts "#{previous_player.name} gets a letter:"
        previous_player.losses += 1

        @fragment = ""
    end

    def take_turn(player)
        puts "\n\nThe fragment so far is: #{@fragment}...\n\n"

        guess = player.guess
        until valid_play?(guess)
            player.alert_invalid_guess
            guess = player.guess
        end

        @fragment += guess
    end

    def current_player
        @players[@player_number]
    end

    def previous_player
        @players[@player_number-1]
    end

    def next_player!
        @player_number += 1
        @player_number = @player_number % @players.length
    end

    def valid_play?(char)
        char.length == 1 && ALPHABET.include?(char) && @dictionary.include_prefix?(@fragment + char)
    end

    def record(player)
        if player.losses == 0
            "_ " * GHOST.length
        else
            GHOST[0...player.losses] +(" _" * (GHOST.length - player.losses))
        end
    end

    def display_standings
        puts "\n-------------------------"
        @players.each do |player| 
            puts player.name + ":\n    " + record(player)
        end
        puts "-------------------------\n"
    end

    def out?(player)
        if player.losses == GHOST.length
            puts "#{player.name} is a #{GHOST}!! They are eliminated from play."
            @players.delete(player)
            @player_number -= 1
            puts "\n\n"
        end
    end
end

# testing code
if __FILE__ == $PROGRAM_NAME
    test_game = Game.new("player1", "player2", "player3")
    test_game.run
end