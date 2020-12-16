require_relative "piece.rb"
require_relative "slideable.rb"

class Queen < Piece
    include Slideable
    def symbol
        "♛".colorize(@color)
    end

    def move_dirs
        horizontal_dirs + diagonal_dirs
    end
end
