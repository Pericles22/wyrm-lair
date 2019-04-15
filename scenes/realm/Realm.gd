extends Node2D

func _ready():
	var realm = makeRealm(7)
	print('the realm!', realm)

func makeRealm(criticalPathLength):
	# using this while loop for now to safeguard against the big
	# TODO case - where the algorithm corners itself. Since it's
	# so rare, randomly trying again is probably fine .. forever
	var realm = null
	
	while (!realm):
		realm = $CriticalPathMaker.makeCriticalPath(criticalPathLength)
  
	# extend the non-critical-path paths a little to throw the player off
	# for now it is possible that there are no branches off the critical path
	# so skip this part if that's the case
	var numNeededRooms = realm.neededRooms.size()
	if (numNeededRooms):
		realm = $Fluffer.addFluff(floor(criticalPathLength / 2), realm.rooms, realm.neededRooms)

	# dead-end or loop back all the loose ends
	return $Filler.fillNeededRooms(realm.rooms, realm.neededRooms)
