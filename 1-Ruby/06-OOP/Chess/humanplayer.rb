require_relative "player"

class HumanPlayer < Player
    def make_move(board)
        input = nil
        until input.is_a?(Array)
            system("clear")
            @display.render
            input = @display.cursor.get_input
        end
        
        input
    end
end