class Party
    attr_reader :guests, :room, :name, :hotel
    
    def initialize(name, hotel)
        @name = name
        @guests = []
        @room = nil
        @hotel = hotel
        @hotel.check_in_party(self)
    end
    def number_of_guests
        @guests.length
    end
    #add guest to party
    def add_guest(guest)
        @guests << guest
    end
    #assigns room to party
    def assign_room(room)
        @room = room
    end
    #removes room from party
    def remove_room
        @room = nil
    end
    def has_room?
        !@room.nil?
    end
end
