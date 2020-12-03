require "byebug"

"""
already know trivially how to do stack/queue with array, for more of a challenge 
use doubly-linked list as underlying data structure
"""

"""EXERCISE 1: DIY STACK"""
class MyStack
    def initialize
      @top = nil
    end

    def push(el)
        new_node = Node_dbl_link.new(el)
        @top.next = new_node if @top
        new_node.prev = @top
        @top = new_node
    end

    def pop
        return nil unless @top
        out = @top
        @top = out.prev
        @top.next = nil if @top
        out.data
    end

    def peek
      @top.nil? ? nil : @top.data
    end
end

class Node_dbl_link
    attr_accessor :next, :prev, :data
    def initialize(data = nil)
        @next = nil
        @prev = nil
        @data = data
    end
end


"""EXERCISE 2: QUEUE"""
class MyQueue
    def initialize
        @first = nil
        @last = nil
    end
    
    def enq(el)
        new_node = Node_dbl_link.new(el)
        if !@last
            @last = new_node
            @first = new_node
        else
            new_node.next = @last
            @last.prev = new_node
            @last = new_node
        end
    end

    def deq
        if !@first
            nil
        elsif @first == @last
            out = @first.data
            @first, @last = nil, nil
            out
        else
            out = @first
            @first = out.prev
            @first.next = nil if @first
            out.data
        end
    end

    def peek
        @first.nil? ? nil : @first.data
    end
end

"""EXERCISE 3: MAP"""
#required: do it with only 2D arrays
# set(key, value), get(key), delete(key), show
class MyMap
    def initialize
        @keys = []
        @values = []
    end

    def set(k, v)
        i = @keys.index(k)
        if i
            @values[i] = v
        else
            @keys << k
            @values << v
        end
        show
    end

    def get(k)
        i = @keys.index(k)
        i ? @values[i] : nil
    end

    def delete(k)
        i_delete = @keys.index(k)
        if i_delete
            @keys = @keys.reject.with_index{|v, i| i == i_delete}
            @values = @values.reject.with_index{|v, i| i == i_delete}
        end
        show
    end

    def show
       @keys.zip(@values) 
    end
end
