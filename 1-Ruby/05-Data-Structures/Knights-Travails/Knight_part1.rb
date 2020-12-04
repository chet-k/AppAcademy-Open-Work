require_relative "poly_tree_node.rb"
require "byebug"

class KnightPathFinder
    
    DELTAS = [[-2, 1],
              [-1, 2],
              [1, 2],
              [2, 1],
              [2, -1],
              [1, -2],
              [-1, -2],
              [-2, -1]]

    def self.valid_moves(pos)
        moves = DELTAS.map {|d| [d[0] + pos[0], d[1] + pos[1]]}
        moves.select{|move| move[0].between?(0,7) && move[1].between?(0,7)}
    end
    
    def initialize(start_pos = [0,0])
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = Set.new([start_pos])
        build_move_tree
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            node = queue.pop
            next_moves = new_move_positions(node.value)
            next_moves.each do |next_pos| 
                new_node = PolyTreeNode.new(next_pos)
                node.add_child(new_node)
            end
            node.children.each {|child| queue.unshift(child)}
        end
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos).reject {|move| @considered_positions.include?(move)}
        new_moves.each {|move| @considered_positions.add(move)}
        new_moves
    end
end