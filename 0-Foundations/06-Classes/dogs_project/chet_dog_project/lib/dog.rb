class Dog
    def initialize(name, breed, age, bark, favorite_foods)
        @name = name
        @breed = breed
        @age = age
        @bark = bark
        @favorite_foods = favorite_foods
        
        # would have to also update this every time we update @favorite_foods
        #@favorite_foods_downcase = @favorite_foods.map {|item| item.downcase}
    end

    def name
        @name
    end

    def breed
        @breed
    end

    def age
        @age
    end

    def age=(num)
        @age = num
    end

    def bark
        if @age > 3
            return @bark.upcase
        else
            return @bark.downcase
        end
    end

    def favorite_foods
        @favorite_foods
    end

    def favorite_food?(item)
        #@favorite_foods_downcase.include?(item.downcase)
        #don't forget what we've just been learning about blocks & constants!
        
        @favorite_foods.map(&:downcase).include?(item.downcase)
    end

end
