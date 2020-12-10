require "singleton"

class Piece
    attr_reader :color
    attr_accessor :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def pos_on_board?(p)
        p.all? {|xy| xy.between?(0,7)}
    end
    
end

class NullPiece < Piece
    include Singleton
    attr_reader :color, :symbol
    def initialize
        @color = nil
        @symbol = nil
    end 
end