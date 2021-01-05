require_relative '5_minmaxstack.rb'

class MinMaxStackQueue
    def initialize
        @outstack = MinMaxStack.new
        @instack = MinMaxStack.new
    end

    def size
        @outstack.size + @instack.size
    end

    def empty?
        @outstack.empty? && @instack.empty?
    end

    def enqueue(el)
        @instack.push(el)
    end

    def dequeue
        slinky if @outstack.empty?
        @outstack.pop
    end

    def peek
        slinky if @outstack.empty?
        @outstack.peek
    end

    def min
        if empty?
            nil
        elsif @instack.empty?
            @outstack.min
        elsif @outstack.empty?
            @instack.min
        else
            [@instack.min, @outstack.min].min
        end
    end

    def max
        if empty?
            nil
        elsif @instack.empty?
            @outstack.max
        elsif @outstack.empty?
            @instack.max
        else
            [@instack.max, @outstack.max].max
        end
    end

    def inspect
        @instack.store + @outstack.store.reverse
    end

    private

    def slinky
        @outstack.push(@instack.pop[:val]) until @instack.empty?
    end
end