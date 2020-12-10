require_relative "piece.rb"
require "byebug"

class Board
    attr_reader :null_piece
    def initialize
        @null_piece = NullPiece.instance

        @rows = Array.new(8) {Array.new(8) {@null_piece}}
        populate_board
    end

    def [](pos)
        r, c = pos
        @rows[r][c]
    end

    def []=(pos, val)
        r, c = pos
        @rows[r][c] = val
    end

    def move_piece(color, start_pos, end_pos)
        raise EmptySquareError if self[start_pos] == @null_piece
        raise unless valid_pos?(end_pos)

        piece = self[start_pos]

        self[end_pos] = piece
        piece.pos = end_pos

        self[start_pos] = @null_piece
    end

    def valid_pos?(pos)
        pos.all? {|i| i.between?(0,7)}
    end

    # def add_piece(pos, piece)
    #     self[pos] = piece
    # end

    private

    def populate_board
        #black at top
        # (0..7).each {|column| @rows[0][column] = Piece.new }
        # (0..7).each {|column| @rows[1][column] = Piece.new }

        #white at bottom
        # (0..7).each {|column| @rows[6][column] = Piece.new }
        # (0..7).each {|column| @rows[7][column] = Piece.new }
    end
end

class EmptySquareError < StandardError
end