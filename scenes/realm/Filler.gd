extends Node

var Utils

func _ready():
	Utils = get_parent().get_node('Utils')
	
func fillNeededRooms(rooms, neededRooms):
	var newRooms = rooms.duplicate()

	for coords in neededRooms.keys():
		var requirements = neededRooms[coords]

		# find the one room type that exactly meets the requirements
		var roomType
		
		for room in Utils.allRooms:
			if requirements.has(Utils.RIGHT) == room.has(Utils.RIGHT) && requirements.has(Utils.BOTTOM) == room.has(Utils.BOTTOM) && requirements.has(Utils.LEFT) == room.has(Utils.LEFT)  && requirements.has(Utils.TOP) == room.has(Utils.TOP):
				roomType = room
				break
    
		newRooms[coords] = {
			coords = coords,
			isEnd = false,
			isOnCriticalPath = false,
			isStart = false,
			type = roomType.type,
		}
	
	return newRooms
