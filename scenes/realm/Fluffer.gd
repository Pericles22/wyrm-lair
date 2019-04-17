extends Node

var Utils

func _ready():
	Utils = get_parent().get_node('Utils')

func addFluff(iterations: int, rooms: Dictionary, neededRooms: Dictionary):
	if (iterations == 0 || !neededRooms.size()):
		return { rooms = rooms, neededRooms = neededRooms }
	
	# pick one of the neededRooms and extend its path (to better distract the player)
	var coords = Utils.pick(neededRooms.keys())
	var neededRoomRequirements = neededRooms[coords]
	var currentRoomType = chooseNeededRoomBranchType(neededRoomRequirements, coords, rooms, neededRooms)
	
	# accept failure and keep going (there may not even be any branchable neededRooms)
	if (!currentRoomType):
		return addFluff(iterations - 1, rooms, neededRooms)
	
	# after picking the room type:
	# - add it to rooms and remove from neededRooms
	var newRooms = rooms.duplicate()
	newRooms[coords] = {
		coords = coords,
		isEnd = false,
		isOnCriticalPath = false,
		isStart = false,
		type = currentRoomType.type,
	}
	var newNeededRooms = neededRooms.duplicate()
	newNeededRooms.erase(coords)
	
	# - find the possible directions from this room and update those needed room requirements
	var possibleDirections = Utils.getRoomDirections(currentRoomType, neededRoomRequirements)

	for direction in possibleDirections:
		var directionCoords = Utils.getDirectionCoords(coords, direction)
		var reversedDirection = Utils.reverseDirection(direction)
		var newRequirements = {}
		newRequirements[reversedDirection] = true

		if newNeededRooms.has(directionCoords):
			var combinedRequirements = Utils.mergeDictionaries(newNeededRooms[directionCoords], newRequirements)
			newNeededRooms[directionCoords] = combinedRequirements
		else:
			newNeededRooms[directionCoords] = newRequirements
	
	# recurse with next room
	return addFluff(iterations - 1, newRooms, newNeededRooms)

func chooseNeededRoomBranchType(requirements, coords, rooms, neededRooms):
	var availableRoomTypes = Utils.pathRooms.duplicate()
	
	if requirements.has(Utils.RIGHT):
		for room in availableRoomTypes.duplicate():
			if !room.has(Utils.RIGHT):
				availableRoomTypes.remove(availableRoomTypes.find(room))

	if requirements.has(Utils.BOTTOM):
		for room in availableRoomTypes.duplicate():
			if !room.has(Utils.BOTTOM):
				availableRoomTypes.remove(availableRoomTypes.find(room))

	if requirements.has(Utils.LEFT):
		for room in availableRoomTypes.duplicate():
			if !room.has(Utils.LEFT):
				availableRoomTypes.remove(availableRoomTypes.find(room))

	if requirements.has(Utils.TOP):
		for room in availableRoomTypes.duplicate():
			if !room.has(Utils.TOP):
				availableRoomTypes.remove(availableRoomTypes.find(room))

	var roomType
	
	while availableRoomTypes.size():
		roomType = Utils.pick(availableRoomTypes)
		
		if isValidNeededRoomBranchType(roomType, requirements, coords, rooms, neededRooms): break
		
		# nope - remove this room type from the list of available room types and try another
		availableRoomTypes.remove(availableRoomTypes.find(roomType))

	if !availableRoomTypes.size(): return false
	
	return roomType

# Needed rooms can branch into other needed rooms (unlike rooms in the critical path)
# but they still can't branch into existing rooms if those rooms didn't specify
# this room as a requirement (meaning they don't have an exit facing this room)
func isValidNeededRoomBranchType(roomType, requirements, originalCoords, rooms, neededRooms):
	var x = originalCoords.x
	var y = originalCoords.y

	if !requirements.has(Utils.RIGHT) && roomType.has(Utils.RIGHT):
		var coords = Vector2(x + 1, y)
		
		if rooms.has(coords): return false

	if !requirements.has(Utils.BOTTOM) && roomType.has(Utils.BOTTOM):
		var coords = Vector2(x, y + 1)
		
		if rooms.has(coords): return false

	if !requirements.has(Utils.LEFT) && roomType.has(Utils.LEFT):
		var coords = Vector2(x - 1, y)
		
		if rooms.has(coords): return false

	if !requirements.has(Utils.TOP) && roomType.has(Utils.TOP):
		var coords = Vector2(x, y - 1)
		
		if rooms.has(coords): return false

	return true # all checks passed!
