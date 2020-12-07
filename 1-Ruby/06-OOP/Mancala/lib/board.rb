require "byebug"

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14)
    @player1 = name1
    @player2 = name2
    place_stones
  end

  def place_stones
    @cups.map!.with_index {|cup, i| cup = (i == 6 || i == 13) ? [] : [:stone, :stone, :stone, :stone]}
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless start_pos.between?(0,13)
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    other_player = current_player_name == @player1 ? @player2 : @player1

    stones_to_move = @cups[start_pos].dup
    @cups[start_pos] = []
    
    pos = start_pos
    until stones_to_move.empty?
      pos = (pos + 1) % 14
      @cups[pos] << stones_to_move.pop unless player_store?(pos, other_player)  
    end
    
    render
    next_turn(pos, current_player_name)
  end

  def next_turn(ending_cup_idx, current_player_name)
    if player_store?(ending_cup_idx, current_player_name)
      :prompt
    elsif @cups[ending_cup_idx] == [:stone]
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?{|cup| cup.empty?} || @cups[6..12].all?{|cup| cup.empty?}
  end

  def winner
    return :draw if @cups[6] == @cups[13]
    @cups[6].length > @cups[13].length ? @player1 : @player2
  end

  private

  def player_store?(i, player)
    return true if i == 6 && player == @player1
    return true if i == 13 && player == @player2
    false
  end
end

if __FILE__ == $PROGRAM_NAME
  # b = Board.new("Chet","Hannah")
  # puts b.cups
  # b.make_move(5, "Chet")
end
