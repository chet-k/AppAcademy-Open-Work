class Towers_Game
    attr_reader :size, :towers
    def initialize(size = 3)
        @size = [size, 3].max
        @towers = [(1..@size).to_a.reverse,[],[]]
        @moves = 0
    end

    def [](n)
        @towers[n]
    end

    def play
        until won?
            system("clear")
            p @towers

            start, finish = get_move
            move(start, finish)
        end

        system("clear")
        p towers
        puts "\n\n Congratulations! you won in #{@moves} moves"
    end

    def move(start, finish)
        if valid_move?(start,finish)
            disk = @towers[start].pop
            @towers[finish] << disk
            @moves += 1
        else
            puts "invalid move. try again."
            sleep(0.5)
        end
    end

    def valid_move?(start, finish)
        #start & finish must be between 0-2
        return false unless start.between?(0,2) && finish.between?(0,2)

        #start cannot == finish
        return false if start == finish
        
        #start tower must have disks
        return false if self[start].empty?
        
        #finish tower does not need disks
        return true if self[finish].empty?

        #top of finish pile cannot be smaller than top of start pile
        return false if self[finish][-1] < self[start][-1]
        
        true
    end

    def won?
        self[0].empty? && self[1].empty? && self[2].length == @size
    end

    def get_move
        start, finish = nil, nil
        
        until start && finish
            if start 
                puts "Move disk from #{start} TO where?"
                n = gets.chomp
                finish = n.to_i if valid_input?(n)
            else
                puts "Move disk FROM where?"
                n = gets.chomp
                start = n.to_i if valid_input?(n)
            end
        end
        
        [start, finish]
    end

    private
    def valid_input?(n)
        begin
            n = Integer(n)
            n.between?(0,2)
        rescue ArgumentError
            false
        end        
    end
end