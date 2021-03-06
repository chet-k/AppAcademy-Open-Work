require_relative "piece.rb"

class Pawn < Piece
    def symbol
        "♟︎".colorize(@color)
    end

    def moves
        out = forward_steps+ side_attacks
        out.select {|p| @board.valid_pos?(p)}
    end

    private
    def forward_dir
        @color == :white ? -1 : 1
    end
    
    def at_start_row?
        start = forward_dir == -1 ? 6 : 1
        @pos[0] == start
    end

    def forward_steps
        x, y = @pos
        
        step1 = [x + forward_dir, y]
        return [] unless @board[step1].empty?
        return [step1] unless at_start_row?
        
        step2 = [x + 2 * forward_dir, y]
        [step1] + [step2]
    end
    
    def side_attacks
        x, y = @pos
        attacks = [[x + forward_dir, y - 1],[x + forward_dir, y + 1]]
        
        # side moves only allowed on enemy pieces
        attacks.select {|p| @board.valid_pos?(p) && 
                            !@board[p].empty? && 
                            @board[p].color != @color} 
    end
end