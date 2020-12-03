require_relative "board"

class Game

    def initialize(path_to_grid)
        @board = Board.new(Board.from_file(path_to_grid))
    end

    def play
        system("clear")
        puts @board.render

        until @board.solved?
            pos = nil
            pos = get_pos_from_user until pos
            val = get_value_from_user
            
            until @board.valid_move?(pos, val)
                puts "Invalid play. Try again."
                pos = get_pos_from_user until pos
                val = get_value_from_user
            end

            @board[pos] = val

            system("clear")
            puts @board.render
        end
        puts "\n\n\n\nPUZZLE SOLVED!"
    end

    def get_value_from_user
        puts "VALUE 1-9 (or 0 for blank):"
        out = gets.chomp.to_i
        until out >= 0 && out < 10
            puts "VALUE must be integer 0-9:"
            out = gets.chomp.to_i
        end
        out
    end

    def get_pos_from_user
        
        puts "ROW:"
        r = gets.chomp.to_i
        until r > 0 && r < 10
            puts "ROW must be integer 1-9:"
            r = gets.chomp.to_i
        end

        puts "COL:"
        c = gets.chomp.to_i
        until c > 0 && c < 10
            puts "COL must be integer 1-9:"
            c = gets.chomp.to_i
        end
        
        pos = [r - 1, c - 1]
        
        if @board.given?(pos)
            puts "Cannot overwrite given tiles."
            return nil
        elsif @board[pos] != 0
            return confirm_overwrite?(pos) ? pos : nil
        end

        pos
    end

    def confirm_overwrite?(pos)

        val = @board[pos]
        m, n = pos
        puts "overwrite #{val} at (#{m + 1}, #{n + 1})? Y/n:"
        yesno = gets.chomp.downcase
        
        yesno == "y" || yesno == "" ? true : false
    end
end


if __FILE__ == $PROGRAM_NAME
    game = Game.new("./puzzles/sudoku1_almost.txt")
    # game = Game.new("./puzzles/sudoku1.txt")
    # game = Game.new("./puzzles/sudoku2.txt")
    # game = Game.new("./puzzles/sudoku3.txt")
    # game = Game.new("./puzzles/sudoku1_solved.txt")
    game.play
end