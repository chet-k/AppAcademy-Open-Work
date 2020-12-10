require "byebug"

module Stepable
    def move_diffs
        # implemented in classes
    end

    def moves
        out = move_diffs.map {|d| [d[0] + self.pos[0], d[1] + self.pos[1]]}
        out.select {|move| move.all?{|xy| xy.between?(0,7)}}
    end
end