require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @opponent_mark = next_mover_mark == :x ? :o : :x
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return @board.winner == toggle_xo(evaluator) if @board.over?

    next_moves = children
    
    if @next_mover_mark == evaluator
      next_moves.all? {|child| child.losing_node?(evaluator)}
    else
      next_moves.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?

    next_moves = children

    if @next_mover_mark == evaluator
      next_moves.any? {|child| child.winning_node?(evaluator)}
    else
      next_moves.all? {|child| child.winning_node?(evaluator)}
    end
  end

  # Generate an array of all moves that can be made after the current move.
  def children
    out = []  
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        out << next_move_node(pos) if @board.empty?(pos)
      end
    end
    out
  end

  private

  def toggle_xo(mark)
    mark == :x ? :o : :x
  end

  def next_move_node(pos)
    new_board = board_dup(@board)
    new_board[pos] = @next_mover_mark
    TicTacToeNode.new(new_board, @opponent_mark, pos)
  end
  
  def board_dup(board)
    new_board = Board.new
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        new_board[pos] = board[pos]
      end
    end
    new_board
  end
end

if __FILE__ == $PROGRAM_NAME
  tn = TicTacToeNode.new(Board.new, :x)
  tn.children
end
