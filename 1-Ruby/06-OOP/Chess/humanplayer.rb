require_relative "player"

class HumanPlayer < Player
    def make_move(board)
        start_pos = nil
        end_pos = nil
        
        until start_pos && end_pos
            system("clear")
            @display.render
            
            if start_pos
                puts "#{@color}'s turn. Move to where?"
                end_pos = @display.cursor.get_input
                @display.reset_errors!
            else
                puts "#{@color}'s turn. Choose a piece to move..."
                start_pos = @display.cursor.get_input
                @display.reset_errors!
            end
        end
        
        [start_pos, end_pos]
    end
end