require "colorize"
require "byebug"

class Piece
    attr_reader :color
    attr_accessor :pos, :board
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def pos_on_board?(p)
        p.all? {|xy| xy.between?(0,7)}
    end 

    def valid_moves
        moves.select {|end_pos| !move_into_check?(end_pos)}
    end

    def to_s
        self.symbol.to_s.colorize(@color)
    end

    def symbol
        #overwritten by subclasses
    end

    def moves
        #overwritten by subclasses
    end

    def empty?
        false
    end
   
    private
    def move_into_check?(end_pos)
        test_board = @board.dup
        test_board.move_piece!(@color, @pos, end_pos)
        test_board.in_check?(@color)
    end
end