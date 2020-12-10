require_relative "piece.rb"
require_relative "board.rb"

class Pawn < Piece
    def symbol
        :pawn
    end

    def moves
        return forward_steps + side_attacks if at_start_row?
        forward_steps
    end

    private
    def forward_dir
        @color == :white ? -1 : 1
    end
    
    def at_start_row?
        start = forward_dir == -1 ? 6 : 1
        self.pos[0] == start
    end

    def forward_steps
        x, y = self.pos
        steps =  [[x + forward_dir, y],[x + 2 * forward_dir, y]]

        steps.select {|p| @board.valid_pos?(p)}
    end
    
    def side_attacks
        x, y = self.pos
        attacks = [[x + forward_dir, y - 1],[x + forward_dir, y + 1]]

        attacks.select {|p| @board.valid_pos?(p)}
    end
end

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    whitepawn = Pawn.new(:white, b, [6, 3])
    p whitepawn.moves
end