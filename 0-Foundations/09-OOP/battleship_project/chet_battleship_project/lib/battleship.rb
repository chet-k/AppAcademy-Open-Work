require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player

    def initialize(n)
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        puts "ships placed: #{@board.num_ships}"
        @board.print
    end

    def lose?
        if @remaining_misses <= 0
            puts "you lose"
            true
        else
            false
        end
    end

    def win?
        if @board.num_ships == 0
            puts "you win"
            true
        else
            false
        end
    end

    def game_over?
        win? || lose?
    end

    def turn
        pos = player.get_move
        hit = @board.attack(pos)
        @remaining_misses -= 1 if !hit
        
        @board.print
        puts "remaining misses: #{@remaining_misses}"
    end

end
