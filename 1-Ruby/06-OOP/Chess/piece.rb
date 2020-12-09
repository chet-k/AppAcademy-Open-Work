require "singleton"

class Piece
        # def initialize(color, board, pos)
        #     @color = color
        #     @board = board
        #     @pos = pos
        # end
end

class NullPiece < Piece
    include Singleton
    attr_reader :color, :symbol
    def initialize
        @color = nil
        @symbol = nil
    end 
end