class Room
    attr_reader :party, :number, :hotel
    
    def initialize(number, hotel)
        @number = number
        @hotel = hotel
        @party = nil

        hotel.add_room(self)
    end
    #checks if room is available
    def is_available
        @party.nil?
    end
    
    private

    #assigns a party to a room if its available
    def assign_party(party)
        return false unless is_available
        @party = party
        true
    end
    #removes party from room
    def leave_room
        old_party = @party
        @party = nil
        old_party
    end
end


    