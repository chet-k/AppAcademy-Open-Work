# require "byebug"

class Board
    attr_reader :size :num_ships
    
    def self.print_grid(grid)
        grid.each {|row| puts row.join" "}
    end

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
        @num_ships = @size / 4
    end

    def [](position)
        row = position[0]
        col = position[1]

        @grid[row][col]
    end

    def []=(position, value)
        row = position[0]
        col = position[1]

        @grid[row][col] = value
    end

    # def num_ships
    #     count = 0
    #     @grid.each do |row|
    #         row.each do |ele|
    #             count += 1 if ele == :S
    #         end
    #     end
    #     count
    # end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            puts "you sunk my battleship!"
            true
        else
            self[position] = :X
            false
        end
    end

    def place_random_ships
        #generate 1D array of unique nums from 1 to n * n
        ship_locations = [*0...@size].sample(@num_ships)
        
        #map the 1D values to 2D pairs
        ship_locations.each do |loc|
            row = loc / @grid.length
            col = loc % @grid[0].length
            @grid[row][col] = :S
        end
    end

    def hidden_ships_grid
        display_grid = []
        @grid.each do |row|
            display_row = row.map do |square|
                if square == :S
                    :N
                else
                    square
                end
            end
            display_grid << display_row
        end
        display_grid
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
