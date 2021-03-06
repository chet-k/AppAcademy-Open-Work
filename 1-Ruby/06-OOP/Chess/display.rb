require_relative "cursor"
require "colorize"

class Display
    attr_accessor :cursor, :notifications
    def initialize(board)
        @board = board
        @cursor = Cursor.new([5,0],board)
        @notifications = {}
    end

    def render
        @board.rows.each_with_index do |row, m|
            row_to_render = []
            row.each_with_index do |piece, n|
                default_bg = color_by_square([m,n])
                bg = [m,n] == @cursor.cursor_pos ? :light_blue : default_bg
                row_to_render << piece.to_s.colorize(:background => bg)
            end
            puts row_to_render.join("")
        end
        @notifications.each {|k, msg| puts msg}
        
        nil
    end

    def reset_errors!
        @notifications.delete(:error)
    end

    def set_check!
        @notifications[:check] = "Check!"
    end

    def unset_check!
        @notifications.delete(:check)
    end

    private
    def color_by_square(pos)
        m, n = pos
        light_bg = :default
        dark_bg = :light_black
        if m.even?
            n.even? ? light_bg : dark_bg
        else
            n.even? ? dark_bg : light_bg
        end
    end
end