require "colorize"
require_relative "pieces"
require_relative "display"

class Board
    attr_reader :null_piece, :rows
    ROW_NAMES = ["8", "7", "6", "5", "4", "3", "2", "1"]
    COL_NAMES = ["a", "b", "c", "d", "e", "f", "g", "h"]

    def initialize
        @null_piece = NullPiece.instance
        @rows = Array.new(8) {Array.new(8) {@null_piece}}
        @pieces = []
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
        start_pos = a1_to_pos(start_pos)
        end_pos = a1_to_pos(end_pos)

        raise EmptySquareError if self[start_pos] == @null_piece
        
        piece = self[start_pos]
        raise unless piece.moves.include?(end_pos)

        self[end_pos] = piece
        piece.pos = end_pos

        self[start_pos] = @null_piece
    end

    def valid_pos?(pos)
        pos.all? {|i| i.between?(0,7)}
    end

    def in_check?(color)
        king_pos = nil
        @pieces.each {|piece| king_pos = piece.pos if piece.symbol == :X && piece.color == color}
        @pieces.each {|piece| return true if piece.moves.include?(king_pos)}
        false
    end

    def render
        puts "----" * 8
        @rows.each do |row|
            str = ""
            row.each do |piece|
                str += "| " + piece.to_s + " "
            end
            puts str + "|"
            puts "----" * 8
        end
        nil
    end

    private

    def a1_to_pos(str)
        c = COL_NAMES.index(str[0])
        r = ROW_NAMES.index(str[1])
        [r, c]
    end

    def populate_board
        #black at top
        # other pieces
        @rows[0][0] = Rook.new(:black, self, [0,0])
        @rows[0][1] = Knight.new(:black, self, [0,1])
        @rows[0][2] = Bishop.new(:black, self, [0,2])
        @rows[0][3] = Queen.new(:black, self, [0,3])
        @rows[0][4] = King.new(:black, self, [0,4])
        @rows[0][5] = Bishop.new(:black, self, [0,5])
        @rows[0][6] = Knight.new(:black, self, [0,6])
        @rows[0][7] = Rook.new(:black, self, [0,7])
        #pawns
        (0..7).each_with_index {|col| @rows[1][col] = Pawn.new(:black, self, [1, col]) }

        #white at bottom
        # other pieces
        @rows[7][0] = Rook.new(:white, self, [7,0])
        @rows[7][1] = Knight.new(:white, self, [7,1])
        @rows[7][2] = Bishop.new(:white, self, [7,2])
        @rows[7][3] = Queen.new(:white, self, [7,3])
        @rows[7][4] = King.new(:white, self, [7,4])
        @rows[7][5] = Bishop.new(:white, self, [7,5])
        @rows[7][6] = Knight.new(:white, self, [7,6])
        @rows[7][7] = Rook.new(:white, self, [7,7])
        #pawns
        (0..7).each_with_index {|col| @rows[6][col] = Pawn.new(:white, self, [6, col]) }

        #also put pieces into one array for access by check/checkmate
        @rows.each do |row|
            row.each do |piece|
                @pieces << piece unless piece.empty?
            end
        end
    end
end

class EmptySquareError < StandardError
end

class PieceCollisionError < StandardError
end

class OutsideBoardError < StandardError
end

if $PROGRAM_NAME == __FILE__
    b = Board.new
    disp = Display.new(b)

    b.move_piece(:black, "f2","f3")
    # disp.render
    b.move_piece(:white, "e7","e5")
    # disp.render
    b.move_piece(:black, "g2","g4")
    # disp.render
    b.move_piece(:white, "d8","h4")
    disp.render

    puts b.in_check?(:white)
    puts b.in_check?(:black)

    
    # moves = 15
    # while moves > 0
    #     system("clear")
    #     disp.render
    #     disp.cursor.get_input
    #     moves -= 1
    # end
    # system("clear")
    # disp.render
end