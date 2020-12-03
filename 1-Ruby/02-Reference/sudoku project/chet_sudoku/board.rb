require_relative "tile"
require "byebug"
require "set"

class Board
    def self.from_file(path)
        file = File.open(path)
        file_data = file.readlines.map(&:chomp)
        file.close

        file_data.map! {|line| line.split("").map!{
            |char| Tile.new(char.to_i, char.to_i > 0 ? true : false)}}
    end

    def initialize(grid)
        @grid = grid
        
        @validation = {}
        ["row", "col", "cell"].each do |id| 
            @validation[id] = Array.new
            9.times {@validation[id] << Set.new}
        end
        update_validation
    end

    def []=(pos, guess)
        m, n = pos
        tile = @grid[m][n]
        tile.value = guess
        
        if guess == 0 #input of 0 is equivalent to setting a tile to blank
            delete_tile(pos)
        else
            update_validation(pos, guess)
        end
    end

    def [](pos)
        m, n = pos
        @grid[m][n].value
    end

    def given?(pos)
        m, n = pos
        @grid[m][n].given
    end

    def solved?
        @validation.each {|key, arr| return false if arr.any?{|set| set.length < 9}}
        true
    end

    def valid_move?(pos, val)
        m, n = pos
        cell = which_cell(pos)

        #have to do this to keep @validation sets accurate.
        #CONFIRM OVERWRITE before checking for valid move.
        delete_tile(pos) if @grid[m][n].value != 0 

        if @validation["row"][m].include?(val) ||
            @validation["col"][n].include?(val) ||
            @validation["cell"][cell].include?(val)
            return false
        end
        true
    end

    def render
        display = []
        @grid.each do |line|
            line_str = line.map(&:to_s)
            line_str.insert(3,"|")
            line_str.insert(7,"|")
            display << line_str.join(" ")
        end
        
        div =  "------|-------|------"
        display.insert(3,div)
        display.insert(7,div)
        display.join("\n")
    end

    private

    def update_validation(pos = nil, val = 0)
        if pos
            count_tile(pos, val)
        else
            @grid.each_with_index do |row, m|
                row.each_with_index do |tile, n|
                    pos = [m,n]
                    val = self[pos]
                    count_tile(pos, val)
                end
            end
        end
    end

    def count_tile(pos, val)
        return if val == 0
        m, n = pos
        @validation["row"][m].add(val)
        @validation["col"][n].add(val)
        
        cell = which_cell(pos) 
        @validation["cell"][cell].add(val)
    end

    def delete_tile(pos)
        m, n = pos
        val = self[pos]

        @validation["row"][m].delete(val)
        @validation["col"][n].delete(val)
        
        cell = which_cell(pos) 
        @validation["cell"][cell].delete(val)

        @grid[m][n].value = 0
    end

    def which_cell(pos)
        m, n = pos
        # numbering scheme for @validation[cell] array of sets:
        #   0 1 2
        #   3 4 5
        #   6 7 8
        cell_row = m / 3
        cell_col = n / 3

        cell_row * 3 + cell_col
    end
end

if __FILE__ == $PROGRAM_NAME
    grid = Board.from_file("./puzzles/sudoku1.txt")
    board = Board.new(grid)
    puts board.render
    board.validation.each {|arr| puts arr}

    pos = [0,1]
    puts board.valid_move?(pos,7)
end