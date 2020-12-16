require_relative "board"
require_relative "display"

class Game
    """Write a Game class that constructs a Board object, 
    then alternates between players (assume two human players for now) 
    prompting them to move. 
    The Game should handle exceptions from Board#move_piece and report them."""
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @p1 = Player.new(:white, @display)
        @p2 = Player.new(:black, @display)
        @current_player = @p1
    end
end