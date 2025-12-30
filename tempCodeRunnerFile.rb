# init.rb
require_relative "hotel"
require_relative "room"
require_relative "party"
require_relative "guest"

def names(list)
  list.map(&:name).join(", ")
end

def room_numbers(list)
  list.map(&:number).join(", ")
end

def show(hotel)
  print "Rooms: #{hotel.number_of_rooms}\n"
  print "Available rooms: #{room_numbers(hotel.available_rooms)}\n"
  print "Parties with rooms: #{names(hotel.parties_with_rooms)}\n"
  print "Parties without rooms: #{names(hotel.parties_without_rooms)}\n"
  print "No vacancies mode? #{!hotel.has_vacancy?}\n"
  print "-" * 30 + "\n"
end

hotel = Hotel.new("Hotel")

# Create rooms
r101 = Room.new(101, hotel)
r102 = Room.new(102, hotel)

# Create parties
party1 = Party.new("Alice", hotel)
party2   = Party.new("Bob", hotel)
party3  = Party.new("Cara", hotel)

# Guests add themselves to their party
Guest.new("Amy", party1)
Guest.new("Al",  party1)
Guest.new("Ben", party2)
Guest.new("Cam", party3)

print "Hotel: #{hotel.name}\n"
show(hotel)

# Assign parties to rooms we created
print "Party1 has room? #{party1.has_room?}\n"
hotel.assign_party_to_room(party1, r101)
hotel.assign_party_to_room(party2, r102)
print "After assigning Party1 to r101 and Party2 to r102:\n"
print "Party1 has room? #{party1.has_room?}\n"
show(hotel)

# Tries to assign Party3 to room 101 (which is occupied)
ok = hotel.assign_party_to_room(party3, r101)
print "Trying to assign Party3 to r101: #{ok}\n"

# Party1 leaves room 101
left_party = hotel.move_party_to_no_room(party1)
print "Room 101 leave_room returned: #{left_party.name}\n"


print "After Party1 leaves r101 (and is checked back in without a room):\n"
show(hotel)

# Now that r101 is free, assign Party3 to 101
hotel.assign_party_to_room(party3, r101)
print "After assigning Party3 to r101:\n"
show(hotel)

# Show Hotel#remove_room on an EMPTY room
r103 = Room.new(103, hotel)
print "After adding Room 103:\n"
show(hotel)

hotel.remove_room(r103)
print "After removing Room 103:\n"
show(hotel)
