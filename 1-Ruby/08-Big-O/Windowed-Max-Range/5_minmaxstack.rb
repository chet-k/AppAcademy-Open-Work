class MinMaxStack
    attr_reader :store
    def initialize
        @store = []
    end

    def peek
        @store[-1][:val]
    end

    def min
        @store[-1][:min]
    end

    def max
        @store[-1][:max]
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def pop
        @store.pop
    end

    def push(val)
        if empty?
            cur_min, cur_max = val, val
        else
            cur_min = [self.min, val].min
            cur_max = [self.max, val].max
        end
        
        @store << {:min => cur_min, :max => cur_max, :val => val}
    end 
end