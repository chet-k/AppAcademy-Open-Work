require "colorize"

class Tile
    attr_reader :given, :value

    def initialize(value = 0, given = false)
        @given = given
        @value = value
    end

    def value=(new_value)
        raise "not allowed to change given tiles." if @given 
        
        @value = new_value
        true
    end

    def to_s
        if @given
            @value.to_s.colorize(:light_blue)#(:background => :red)
        else
            @value.to_s
        end
    end
end 
