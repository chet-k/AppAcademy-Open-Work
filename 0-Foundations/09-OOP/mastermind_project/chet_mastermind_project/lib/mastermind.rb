require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(code_guess)
        puts "exact matches: #{@secret_code.num_exact_matches(code_guess)}"
        puts "near matches: #{@secret_code.num_near_matches(code_guess)}"
    end

    def ask_user_for_guess
        puts "Enter a code"
        user_guess = Code.from_string(gets.chomp)
        print_matches(user_guess)
        @secret_code == user_guess
    end

end
