module Stepable
    def move_diffs
        # implemented in classes
    end

    def moves
        out = move_diffs.map {|d| [d[0] + @pos[0], d[1] + @pos[1]]}
        out.select {|move| @board.valid_pos?(move) && @board[move].color != @color}
    end
end