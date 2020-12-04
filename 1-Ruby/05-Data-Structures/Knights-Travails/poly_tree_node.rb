class PolyTreeNode
    attr_accessor :value, :parent, :children
    def initialize(val = nil)
        @value = val
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        @parent.children.delete(self) if @parent 
        @parent = parent_node
        parent_node.children << self if parent_node
    end

    def add_child(child_node)
        child_node.parent = self unless @children.include?(child_node)
    end

    def remove_child(child_node)
        raise unless @children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target)
        return self if @value == target
        @children.each do |node| 
            search_result = node.dfs(target)
            return search_result unless search_result.nil?
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            node = queue.pop
            return node if node.value == target
            node.children.each {|child| queue.unshift(child)}
        end
    end

    def inspect
        {:value => @value,
        :parent => @parent,
        :children => @children}.to_s
    end
end

