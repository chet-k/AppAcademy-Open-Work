require "byebug"

module Stepable
    def move_diffs
        # implemented in classes
    end

    def moves(board)
        debugger
        out = move_diffs.map {|d| [d[0] + self.pos[0], d[1] + self.pos[1]]}
        out.select {|move| board.valid_pos?(move) && board[move].color != self.color}
    end
end