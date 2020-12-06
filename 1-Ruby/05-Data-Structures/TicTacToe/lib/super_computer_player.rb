require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    move_tree = TicTacToeNode.new(game.board, mark)

    #look for winning moves first
    move_tree.children.each do |node|
      return node.prev_move_pos if node.winning_node?(mark)
    end

    #no winning move found, go through tree again for non-loser
    move_tree.children.each do |node|
      return node.prev_move_pos if !node.losing_node?(mark)
    end

    #should not get through to here
    raise
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
