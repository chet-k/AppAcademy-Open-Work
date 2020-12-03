require "byebug"

class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end
  
  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      true
    else
      false
    end
  end

  def get_matching_indices(letter)
    indices = []
    @secret_word.each_char.with_index {|char, i| indices << i if letter == char}
    indices
  end

  def fill_indices(letter, indices)
    indices.each {|i| @guess_word[i] = letter}
  end

  def try_guess(letter)
    if already_attempted?(letter)
      puts "that has already been attempted"
      return false
    else
      indices = get_matching_indices(letter)
      fill_indices(letter, indices)

      @remaining_incorrect_guesses -= 1  if indices.empty?
      @attempted_chars << letter
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    guess = gets.chomp
    try_guess(guess)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      true
    else
      false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      true
    else
      false
    end
  end
  
end

