class Player
    attr_reader :name
    attr_accessor :losses

    def initialize(player_name)
        @name = player_name
        @losses = 0
    end
    
    def guess
        puts "add a letter, #{@name}:"
        gets.chomp
    end

    def alert_invalid_guess
        puts "\nTry again. Guess must be lowercase a-z, and fragment must be start of a word.\n"
    end
end
