"""
ASSIGNMENT:
Tonight we're going to use an array to implement a basic LRU Cache. 
This will be a simple implementation that doesn't use a hash-map or linked list. 
We will assume our input is limited to Integers, Strings, Arrays, Symbols, and Hashes. 
We will allow the user to set the size of the cache.
"""

class LRUCache

    def initialize(max_size)
        @max_size = max_size
        @data = []
    end

    def count
        @data.length
    end

    def add(el)
        stamp = Time.now
        
        idx = index(el)
        if idx
            @data[idx][1] = stamp
        else idx
            @data.delete(least_recent_el) if @data.length == @max_size
            @data << [el, stamp]
        end
    end

    def show
        @data.sort! {|a,b| a[1] <=> b[1]}
        p @data.map {|el| el[0]}
    end

    private
    def least_recent_el
        oldest = [nil, Time.now]
        @data.each { |cur_pair| oldest = cur_pair if oldest[1] > cur_pair[1] }
        oldest
    end
    
    def index(el)
        @data.each_with_index {|pair, i| return i if pair[0] == el}
        nil
    end
end

if __FILE__ == $PROGRAM_NAME
    johnny_cache = LRUCache.new(4)

    johnny_cache.add("I walk the line")
    johnny_cache.add(5)

    johnny_cache.count # => returns 2

    johnny_cache.add([1,2,3])
    johnny_cache.add(5)
    johnny_cache.add(-5)
    johnny_cache.add({a: 1, b: 2, c: 3})
    johnny_cache.add([1,2,3,4])
    johnny_cache.add("I walk the line")
    johnny_cache.add(:ring_of_fire)
    johnny_cache.add("I walk the line")
    johnny_cache.add({a: 1, b: 2, c: 3})

    johnny_cache.show 
    # => [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
end