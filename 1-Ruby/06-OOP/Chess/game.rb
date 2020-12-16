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
        until @board.checkmate?(@current_player.color)
            begin
                start_pos, end_pos = @current_player.make_move(@board)
                @board.move_piece(@current_player.color, start_pos, end_pos)
                
                swap_turn!
                if @board.in_check?(@color)
                    @display.set_check! 
                else
                    @display.unset_check! 
                end
            rescue StandardError => e
                @display.notifications[:error] = e.message
                retry
            end
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