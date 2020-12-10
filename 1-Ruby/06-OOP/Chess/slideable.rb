module Slideable
    HORIZONTAL_DIRS = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    DIAGONAL_DIRS = [[-1, -1],[-1, 1],[1, 1],[1, -1]]

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        out = []
        move_dirs.each do |direction|
            out += grow_unblocked_moves_in_dir(direction)
        end


    end

    def move_dirs
        #to be implemented by classes
    end

    private
    def grow_unblocked_moves_in_dir(direction)
        dx, dy = direction
        x, y = self.pos 

        
    end

end
"""The Slideable module can implement #moves, but it needs to know 
what directions a piece can move in (diagonal, horizontally/vertically, both). 
Classes that include the module Slideable (Bishop/Rook/Queen) will need to 
implement a method #move_dirs, which #moves will use."""