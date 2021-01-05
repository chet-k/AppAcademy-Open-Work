require_relative '3_mystack.rb'

class StackQueue
    def initialize
        @outstack = MyStack.new
        @instack = MyStack.new
        
    end

    def size
        @outstack.size + @instack.size
    end

    def empty?
        @outstack.empty? && @instack.empty?
    end

    def enqueue(el)
        if empty?
            @outstack.push(el)
        else
            @instack.push(el)
        end
    end

    def dequeue
        slinky if @outstack.empty?
        @outstack.pop
    end

    def peek
        slinky if @outstack.empty?
        @outstack.peek
    end

    private

    def slinky
        @outstack.push(@instack.pop) until @instack.empty?
    end
end