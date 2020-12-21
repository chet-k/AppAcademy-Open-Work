class Towers_Game
    attr_reader :size, :towers
    def initialize(size = 3)
        @size = [size, 3].max
        @towers = [(1..@size).to_a.reverse,[],[]]
    end

    def [](n)
        @towers[n]
    end

    def valid_move?(start, finish)
        #start has disks
        #finish tower is empty
        #top disk is larger than top disk on finish
    end

    def move(start, finish)

    end

    def won?
    end

    def get_input
    end

    private
    def valid_input
    end
end