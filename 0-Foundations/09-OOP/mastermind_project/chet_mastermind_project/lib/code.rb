class Code
  attr_reader :pegs
  
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    !chars.any? { |char| !POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def self.random(sequence_length)
    new_sequence = []
    sequence_length.times {new_sequence << POSSIBLE_PEGS.keys.sample}
    Code.new(new_sequence)
  end

  def self.from_string(sequence_str)
    Code.new(sequence_str.split(""))
  end

  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map {|char| char.upcase}
    else
      raise "invalid pegs"
    end
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code_guess)
    matches = 0
    @pegs.each_with_index {|peg, i| matches += 1 if peg == code_guess[i]}
    matches
  end

  def num_near_matches(code_guess)
    near_matches = 0
    code_guess.pegs.each_with_index do |peg, i| 
      if @pegs.include?(peg) && peg != @pegs[i]
        near_matches += 1 
      end
    end
    near_matches
  end

  def ==(other_code)
    other_code.length == self.length && num_exact_matches(other_code) == self.length
  end

end
