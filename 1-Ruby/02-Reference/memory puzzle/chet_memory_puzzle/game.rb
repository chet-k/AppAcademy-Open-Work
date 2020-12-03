require_relative "card"
require_relative "board"
require_relative "player"
require "byebug"

class Game

    def initialize(player)
        @player = player
        @board = Board.new
        @prev_guess = nil
        @memorize_time = 3
        @tries = 0
        @max_turns = 999
        @total_revealed = 0
        #later: init with DIFFICULTY including max_turns, memorize_time, bombs
    end

    def preview_board
        @board.reveal_all
        
        board_str = @board.render
        countdown = @memorize_time
        until countdown == 0
            system("clear")
            puts board_str + "\nBoard disappears in #{countdown}..."
            sleep(1)
            countdown -= 1
        end
        system("clear")
        
        @board.hide_all
    end

    def play
        preview_board

        until self.game_over?
            system("clear")
            puts @board.render + "\nGUESSES REMAINING: #{@max_turns - @tries}"
            make_guess(@player.prompt(@board))
        end
    end

    def game_over?
        if @board.won?
            system("clear")
            puts @board.render
            puts "Congratulations! You won in #{@tries} turns."
            true
        elsif @tries >= @max_turns
            puts "GAME OVER. No more turns left."
            true
        else
            false
        end
    end

    def make_guess(guessed_pos)
        card = @board[guessed_pos]
        card.reveal
        @player.receive_revealed_card(guessed_pos,card.value)

        if !@prev_guess #first guess
            @prev_guess = guessed_pos
        else # second guess 
            #turn face down unless cards match
            if card == @board[@prev_guess]
                @player.receive_match(guessed_pos,@prev_guess)
            else
                system("clear")
                puts @board.render + "\nNot a match! Try again."
                sleep(1) 

                card.hide
                @board[@prev_guess].hide
            end
            @prev_guess = nil
            @tries += 1
        end
    end
end


if __FILE__ == $PROGRAM_NAME
    choice = ""
    until choice == "H" || choice == "C" || choice == "E"
        system("clear")
        puts "[H]uman or [C]omputer player? ([E] to exit)"
        choice = gets.chomp.upcase
    end
    if choice == "H"
        player = HumanPlayer.new
        game = Game.new(player)
        game.play
    elsif choice == "C"
        player = ComputerPlayer.new
        game = Game.new(player)
        game.play
    end
end