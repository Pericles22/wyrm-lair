extends Node

var Utils

func _ready():
	Utils = get_parent().get_node('Utils')

func chooseRoomType(numRoomsLeft, numRooms, coords, dirToPrevRoom, rooms, neededRooms):
	var availableRoomTypes
	
	if numRoomsLeft == numRooms:
		availableRoomTypes = Utils.allRooms.duplicate() # the first room can be any type
	elif numRoomsLeft == 1:
		availableRoomTypes = Utils.deadEndRooms.duplicate() # the last room must be a dead end
	else:
		availableRoomTypes = Utils.pathRooms.duplicate() # everything else must be a non-dead-end

	# can only pick rooms that have exits pointing to the previous room (if any)
	if dirToPrevRoom:
		# clone to avoid deleting from the list while iterating over it
		var availableRoomTypesClone = availableRoomTypes.duplicate()
		for room in availableRoomTypesClone:
			if !room.has(dirToPrevRoom):
				availableRoomTypes.remove(availableRoomTypes.find(room))

	var roomType

	# keep picking room types until we find one that works or we run out of options
	while (availableRoomTypes.size()):
		roomType = Utils.pick(availableRoomTypes)

		if isValidRoomType(roomType, coords, dirToPrevRoom, rooms, neededRooms): break

		# nope - remove this room type from the list of available room types and try another
		availableRoomTypes.remove(availableRoomTypes.find(roomType))
  
	# failed to find a suitable room type down this path
	# unwind the recursion chain and try a different direction
	if !availableRoomTypes.size(): return false

	return roomType

# make sure all directions (except where we came from) are free game
func isValidRoomType(roomType, originalCoords, dirToPrevRoom, rooms, neededRooms):
	var x = originalCoords.x
	var y = originalCoords.y
	
	if dirToPrevRoom != Utils.RIGHT && roomType.has(Utils.RIGHT):
		var coords = Vector2(x + 1, y)

		if rooms.has(coords) || neededRooms.has(coords): return false

	if dirToPrevRoom != Utils.BOTTOM && roomType.has(Utils.BOTTOM):
		var coords = Vector2(x, y + 1)

		if (rooms.has(coords) || neededRooms.has(coords)): return false

	if dirToPrevRoom != Utils.LEFT && roomType.has(Utils.LEFT):
		var coords = Vector2(x - 1, y)

		if (rooms.has(coords) || neededRooms.has(coords)): return false

	if dirToPrevRoom != Utils.TOP && roomType.has(Utils.TOP):
		var coords = Vector2(x, y - 1)

		if (rooms.has(coords) || neededRooms.has(coords)): return false

	return true # all checks passed!

func makeCriticalPath(numRoomsLeft, numRooms = null, coords = Vector2(0, 0), dirToPrevRoom = '', rooms = {}, neededRooms = {}):
	if !numRooms:
		numRooms = numRoomsLeft

	# base case - no more rooms to add
	if (numRoomsLeft == 0):
		return { rooms = rooms, neededRooms = neededRooms }

	# figure out the room type
	# the first room - 0,0 - can be any room type
	# the rest of the rooms except the last can be any pathRoom
	# the last room type must be a deadEndRoom

	# when picking the room type:
	# - it must have an exit facing the previous room
	# - check all other exits and make sure the rooms in those directions aren't already in neededRooms or rooms
	var currentRoomType = chooseRoomType(numRoomsLeft, numRooms, coords, dirToPrevRoom, rooms, neededRooms)

	# if there are no valid room types, unwind the recursion and try a different direction
	# TODO: this (it's not a common case, but could happen if the algorithm corners itself)
	if (!currentRoomType):
		return false

	# after picking the room type:
	# - add it to rooms
	var newRooms = rooms.duplicate()
	
	newRooms[coords] = {
		coords = coords,
		isEnd = numRoomsLeft == 1,
		isOnCriticalPath = true,
		isStart = numRoomsLeft == numRooms,
		type = currentRoomType.type,
	}

	# - pick the direction to the next room and find those coords
	var unavailableDirections = {}
	unavailableDirections[dirToPrevRoom] = true # fine if there is no prev room
	
	var possibleDirections = Utils.getRoomDirections(currentRoomType, unavailableDirections)
	var dirToNextRoom = Utils.pick(possibleDirections)
	var nextRoomCoords = Utils.getDirectionCoords(coords, dirToNextRoom)
	
	# - add all rooms in the remaining possible directions to neededRooms
	possibleDirections.remove(possibleDirections.find(dirToNextRoom))
	var newNeededRooms = neededRooms.duplicate()
	
	for direction in possibleDirections:
		var directionCoords = Utils.getDirectionCoords(coords, direction)
		var reversedDirection = Utils.reverseDirection(direction)
		var roomRequirements = {}
		roomRequirements[reversedDirection] = true
		
		newNeededRooms[directionCoords] = roomRequirements

	# recurse with next room
	return makeCriticalPath(
		numRoomsLeft - 1,
		numRooms,
		nextRoomCoords,
		Utils.reverseDirection(dirToNextRoom),
		newRooms,
		newNeededRooms
	)
