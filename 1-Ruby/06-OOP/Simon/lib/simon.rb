require "byebug"

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until @game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      system("clear")
      puts color
      sleep(0.5)
    end
  end

  def require_sequence
    @seq.each do |seq_color|
      
      system("clear")
      puts "Your turn! Type each color."
      print "> "

      recalled_color = gets.chomp.downcase
      
      unless recalled_color == seq_color
        puts "!! WRONG !! "
        puts "you guessed #{recalled_color}."
        puts "The correct color was #{seq_color}."
        
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    @seq << COLORS[rand(COLORS.length)]
  end

  def round_success_message
    system("clear")
    puts "Nice one! Simon says......"
    sleep(0.5)
  end

  def game_over_message
    puts "GAME OVER."
  end

  def reset_game
    @game_over = false
    @seq = []
    @sequence_length = 1
  end
end

if $PROGRAM_NAME == __FILE__
  s = Simon.new
  s.play
end
