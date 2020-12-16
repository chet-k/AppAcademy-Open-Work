require_relative "cursor"
require "colorize"

class Display
    attr_accessor :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([5,0],board)
    end

    def render
        horiz_divider = "-" * 29
        
        puts horiz_divider
        @board.rows.each_with_index do |row, m|
            row_to_render = []
            row.each_with_index do |piece, n|
                bg = [m,n] == @cursor.cursor_pos ? :light_white : :light_black
                row_to_render << piece.to_s.colorize(:background => bg)
            end
            puts row_to_render.join(" | ")
            puts horiz_divider
        end
        nil
    end
end