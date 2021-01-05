class MyQueue
    def initialize
        @store = []
    end
    
    def peek
        @store[0]
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def enqueue(el)
        @store << el
    end

    def dequeue
        @store.shift
    end
end