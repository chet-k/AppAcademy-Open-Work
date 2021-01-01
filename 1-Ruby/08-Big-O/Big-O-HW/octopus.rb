class EatingOctopus
    FISH = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

    def self.sluggish
        FISH.each do |fish|
            return fish if FISH.all? {|other_fish| other_fish.length <= fish.length}
        end
    end

    def self.dominant
        FISH.sort_by(&:length)[-1]
    end

    def self.clever
        favorite = ""
        FISH.each { |fish| favorite = fish if fish.length > favorite.length }
        favorite
    end
end

class DancingOctopus
    def self.tile_n_slow(tile_name)
        tiles_arr = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
        tiles_arr.index(tile_name)
    end

    def self.tile_n_constant(tile_name)
        tiles_h = {"up" => 0, 
                    "right-up" => 1, 
                    "right" => 2, 
                    "right-down" => 3,
                    "down" => 4,
                    "left-down" => 5,
                    "left" => 6,
                    "left-up" => 7 }
        tiles_h[tile_name]
    end
end

if $PROGRAM_NAME == __FILE__
    puts "\n\nEating Octopus: return longest fish"
    puts "sluggish: #{EatingOctopus.sluggish}"
    puts "clever: #{EatingOctopus.clever}"
    puts "dominant: #{EatingOctopus.dominant}"

    puts "\n\nDancing Octopus: return tile number of left-up tile"
    puts "slow: #{DancingOctopus.tile_n_slow("left-up")}"
    puts "constant: #{DancingOctopus.tile_n_constant("left-up")}\n\n"
end