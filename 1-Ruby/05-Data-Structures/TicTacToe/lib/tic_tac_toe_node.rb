require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    out = []
    @board.rows.each do |row|
      row.each do |pos|
        unless pos
          out << "child" #test for rspec
        end
      end
    end

    out
  end

  """Write a method children that returns nodes representing all the potential 
  game states one move after the current node. To create this method, it will be
  necessary to iterate through all positions that are empty? on the board object. 
  
  For each empty position, create a node by duping the board and 
  putting a next_mover_mark in the position. 
  
  You'll want to alternate next_mover_mark so that next time the other player 
  gets to move. 
  
  Also, set prev_move_pos to the position you just marked, for reasons that will make 
  sense when we use it later."""
end

if __FILE__ == $PROGRAM_NAME
  tn = TicTacToeNode.new(Board.new, :x)
  tn.children
end
