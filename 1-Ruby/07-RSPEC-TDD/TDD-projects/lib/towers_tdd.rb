class Towers_Game
    attr_reader :size, :towers
    def initialize(size = 3)
        @size = [size, 3].max
        @towers = [(1..@size).to_a.reverse,[],[]]
    end

    def [](n)
        @towers[n]
    end

    def play
    end

    def valid_move?(start, finish)
        #start & finish must be between 0-2
        return false unless start.between?(0,2) && finish.between?(0,2)
        
        #start tower must have disks
        return false if self[start].empty?
        
        #finish tower does not need disks
        return true if self[finish].empty?

        #top of finish pile cannot be smaller than top of start pile
        return false if self[finish][-1] < self[start][-1]
        
        true
    end

    def move(start, finish)
        if valid_move?(start,finish)
            disk = @towers[start].pop
            @towers[finish] << disk
        else
            puts "invalid move. try again."
        end
    end

    def won?
        self[0].empty? && self[1].empty? && self[2].length == @size
    end

    def get_input
    end

    private
    def valid_input
    end
end