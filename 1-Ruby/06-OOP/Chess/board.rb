require_relative "piece.rb"
require "byebug"

class Board
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
        piece = self[start_pos]
        self[end_pos] = piece
        self[start_pos] = @null_piece
    end

    def valid_pos?(pos)
    end

    private

    def populate_board
        #black at top
        (0..7).each {|column| @rows[0][column] = Piece.new }
        (0..7).each {|column| @rows[1][column] = Piece.new }

        #white at bottom
        (0..7).each {|column| @rows[6][column] = Piece.new }
        (0..7).each {|column| @rows[7][column] = Piece.new }
    end
end