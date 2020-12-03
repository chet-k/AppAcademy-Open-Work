require_relative "card"
require "byebug"

class Board
    
    LETTERS = "AABBCCDDEEFFGGHH"
    attr_reader :size
    
    def initialize
        @size = 4
        @board = Array.new(@size) {Array.new(@size)}
        @total_revealed = 0
        populate
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def populate
        deck = LETTERS.split("").map{|a| Card.new(a)}
        deck.shuffle!

        @board.each do |row|
            row.map! {|slot| slot = deck.pop}
        end
    end

    def reveal(guessed_pos)
        row, col = guessed_pos
        guessed_card = @board[row][col]
        
        if guessed_card.reveal 
            guessed_card.face_value
        else
            nil
        end
    end

    def render
        render_str = "  " + (0...@size).to_a.join(" ") + "\n"
        @board.each_with_index do |row, i|
            render_str += i.to_s + " " + row.map{|card| card.face_value}.join(" ") + "\n"
        end
        render_str
    end

    def reveal_all
        @board.each do |row|
            row.each {|card| card.reveal}
        end
    end

    def hide_all
        @board.each do |row|
            row.each{|card| card.hide}
        end
    end

    def won?
        @board.each do |row|
            return false if row.any?{|card| !card.face_up?}
        end
        true
    end
end

# if __FILE__ == $PROGRAM_NAME
# end