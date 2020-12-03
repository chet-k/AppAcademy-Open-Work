require_relative "card"
require_relative "board"
require_relative "game"
require "byebug"
require "set"

class HumanPlayer
    
    def prompt(board) #return position and handle game rules errors
        puts "Please enter the position of the card you'd like to flip (e.g. '2,3')"
        pos = nil
        until pos
            pos = get_input
            if !pos
                next
            elsif pos[0] >= board.size || pos[1] >= board.size
                pos = nil
                puts "Try again - #{pos} is out of range."
            elsif board[pos].face_up?
                pos = nil
                puts "Try again - that card is already face up."
            end
        end
        pos
    end

    def get_input #and handle input errors
        begin
            pos = gets.chomp.split(",")
            pos.map! {|coord| Integer coord} 
            raise if pos.length != 2
            pos
        rescue
            puts "Input not readable. Required format: '#,#'" 
            nil
        end
    end

    def receive_revealed_card(pos,value)
        #dummy method
    end

    def receive_match(pos1, pos2) 
        #dummy method
    end
end


class ComputerPlayer
    def initialize
        @known_cards = Hash.new([])
        @matched_cards = Set.new
        @first_guess = nil
        
        @not_seen = []
        (0..3).each {|m| (0..3).each {|n| @not_seen << [m,n]} }
        @not_seen.shuffle!
    end

    def receive_revealed_card(pos,value) #store position and value in @known_cards hash.
        @known_cards[pos] = value
    end

    def receive_match(*positions)
        positions.each do |pos|
            @matched_cards.add(pos)
            # @known_cards.delete(pos)
        end
    end

    def prompt(board)
        if !@first_guess #on first guess, i.e. first guess variable is empty
            pos = known_match || @not_seen.pop 
            @first_guess = pos            
        else #second guess
            pos = new_match(@first_guess) || @not_seen.pop
            @first_guess = nil
        end
        
        puts "CP guesses: #{pos}"
        sleep(0.5)
        
        pos
    end

    def known_match #check if two un-matched cards have already been revealed
        other_values = Set.new
        @known_cards.each do |pos, value|
            if other_values.include?(value) && !@matched_cards.include?(pos)
                @matched_cards.add(pos)
                return pos
            end
            other_values.add(value)
        end
        nil
    end

    def new_match(guessed_pos) #check if first guess revealed a known card
        find_value = @known_cards[guessed_pos]
        @known_cards.each do |pos, value| 
            if pos != guessed_pos && value == find_value
                return pos 
            end
        end
        nil
    end
end
