class Guest
    attr_reader :name, :party

    def initialize(name, party)
        @name = name
        @party = party
        party.add_guest(self)
    end
end