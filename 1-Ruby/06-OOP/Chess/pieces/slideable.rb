module Slideable
    HORIZONTAL_DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    DIAGONAL_DIRS = [[-1, -1],[-1, 1],[1, 1],[1, -1]]

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves#(board)
        out = []
        move_dirs.each do |direction|
            out += grow_unblocked_moves_in_dir(direction)
        end
        out
    end

    def move_dirs
        #to be implemented by classes
    end

    private
    def grow_unblocked_moves_in_dir(direction)
        dx, dy = direction
        move = [@pos[0]+dx, @pos[1]+dy]
        
        out = []
        while @board.valid_pos?(move)
            break if @board[move].color == @color
            out << move
            
            break if @board[move] != @board.null_piece
            move = [move[0] + dx, move[1] + dy]
        end
        
        out
    end
end
