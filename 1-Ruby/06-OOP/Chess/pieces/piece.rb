require "colorize"

class Piece
    attr_reader :color, :board
    attr_accessor :pos
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def pos_on_board?(p)
        p.all? {|xy| xy.between?(0,7)}
    end 

    def to_s
        self.symbol.to_s.colorize(@color)
    end

    def symbol
        #overwritten by subclasses
    end

    def empty?
        false
    end
end