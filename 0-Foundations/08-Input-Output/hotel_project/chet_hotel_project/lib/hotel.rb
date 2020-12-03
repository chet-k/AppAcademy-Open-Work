require_relative "room"

class Hotel
    def initialize(hotel_name, room_hash)
        @name = hotel_name
        @rooms = {}
        room_hash.each do |room_name, room_capacity|
            @rooms[room_name] = Room.new(room_capacity)            
        end
    end

    def name
        name_capitalized = []
        @name.split(" ").each do |word| 
            name_capitalized << word[0].upcase + word[1..-1].downcase
        end
        name_capitalized.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        if @rooms.has_key?(name)
            true
        else
            false
        end
    end

    def check_in(guest, room_name)
        if !room_exists?(room_name)
            puts "sorry, room does not exist"
        else
            if @rooms[room_name].add_occupant(guest)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        capacity = 0
        @rooms.each_value {|room| capacity += room.available_space}
        if capacity > 0
            true
        else
            false
        end
    end

    def list_rooms
        @rooms.each { |room_name, room| puts "#{room_name}: #{room.available_space}" }
    end

end
