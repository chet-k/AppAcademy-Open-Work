require_relative "board"
require_relative "display"
require_relative "humanplayer"
require "byebug"

class Game
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @p1 = HumanPlayer.new(:white, @display)
        @p2 = HumanPlayer.new(:black, @display)
        @current_player = @p1
    end

    def play
        game_over = false
        until game_over
            start_pos = @current_player.make_move(@board)
            end_pos = @current_player.make_move(@board)
            @board.move_piece(@current_player.color, start_pos, end_pos)
            swap_turn!
            
            game_over = @board.checkmate?(@current_player.color)
        end
    end

    private
    def swap_turn!
        @current_player = @current_player == @p1 ? @p2 : @p1
    end
end

if $PROGRAM_NAME == __FILE__
    g = Game.new
    g.play
end