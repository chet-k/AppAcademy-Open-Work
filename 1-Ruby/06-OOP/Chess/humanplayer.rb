class HumanPlayer < Player
    def make_move(board)
        input = nil
        until input.is_a?(Array)
            system("clear")
            input = @display.cursor.get_input
        end
    end
end