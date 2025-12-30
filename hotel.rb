class Hotel
    attr_reader :name, :rooms, :parties_without_rooms

    def initialize(name)
        @name = name
        @parties_without_rooms = []
        @rooms = []
        @no_vacancies = false
    end
    #updates vacancy status
    def update_vacancy
        @no_vacancies = @parties_without_rooms.length > available_rooms.length
    end
    #checks if hotel has a vacancy
    def has_vacancy?
        !@no_vacancies
    end
    #checks if rooms are available
    def available_rooms
        @rooms.select { |room| room.is_available }
    end 
    #checks in party 
    def check_in_party(party)
        @parties_without_rooms << party unless @parties_without_rooms.include?(party)
        update_vacancy
        return false unless has_vacancy?
        true
    end
    #adds room to room list
    def add_room(room)
        @rooms << room
        update_vacancy
    end
    #removes room from room list
    def remove_room(room)
        if room.party
            move_party_to_no_room(room.party)
        end
        @rooms.delete(room)
        update_vacancy
    end
    def number_of_rooms
        @rooms.length
    end
    #assigns party to room
    def assign_party_to_room(party, room)
        return false unless room.is_available
        @parties_without_rooms.delete(party)
        room.send(:assign_party, party)
        party.assign_room(room)
        update_vacancy
        true
    end
    #moves party to no room list
    def move_party_to_no_room(party)
        if party.room
            party.room.send(:leave_room)
            party.remove_room
        end
        @parties_without_rooms << party unless @parties_without_rooms.include?(party)
        update_vacancy
        party
    end
    def parties_with_rooms
        @rooms.map(&:party).compact
    end
end
    