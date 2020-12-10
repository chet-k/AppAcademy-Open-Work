require_relative "piece.rb"
require_relative "board.rb"
require_relative "slideable.rb"

class Rook < Piece
    include Slideable
    def symbol
        :rook
    end

    def move_dirs
        horizontal_dirs
    end
end

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    whiterook1 = Rook.new(:white, b, [0,0])
    whiterook2 = Rook.new(:white, b, [0,3])
    blackrook = Rook.new(:black, b, [3,0])
    
    b[[0,0]] = whiterook1
    b[[0,3]] = whiterook2
    b[[3,0]] = blackrook

    p whiterook1.moves
end