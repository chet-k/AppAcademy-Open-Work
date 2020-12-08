# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError
    puts "#{str} is not a number readable as int."
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]
class CoffeeIsAlmostFruitError < StandardError
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeIsAlmostFruitError
  else
    raise StandardError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeIsAlmostFruitError => e
    puts "I like coffee but it's not a fruit. Try again!"
    retry
  rescue StandardError
    puts "THAT IS NOT A FRUIT. I AM NO LONGER FRIENDLY"
  end
end  

# PHASE 4
class FriendshipTooShortError < StandardError
  def initialize(msg="Friend not known long enough to be a BestFriend")
    super
  end
end

class EmptyArgumentError < StandardError
  def initialize(msg="Non-empty arguments required.")
    super
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise FriendshipTooShortError if @yrs_known < 5
    raise EmptyArgumentError if @name.length == 0 || @fav_pastime.length == 0
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known} years. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


