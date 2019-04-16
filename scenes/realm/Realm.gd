extends Node2D

const TILE_SIZE = 16
const ROOM_TILES = 32
const ROOM_SIZE = ROOM_TILES * TILE_SIZE
const player = preload('res://scenes/characters/player/Player.tscn')

func _ready():
	randomize()
	var realm = makeRealm(7)
	drawRealm(realm, 'farmland')

func drawRealm(realm, realmType):
	# cache the loaded scenes as we encounter them
	var loadedScenes = {}
	var roomSizeVector = Vector2(ROOM_SIZE, ROOM_SIZE)
	
	for coords in realm.keys():
		var roomDefinition = realm[coords]
		var type = roomDefinition.type.to_upper()
		var fileName = str('res://scenes/rooms/', realmType, '/', type, '1.tscn')
		var scene
		
		if loadedScenes.has(fileName):
			scene = loadedScenes[fileName]
		else:
			scene = load(fileName)
			loadedScenes[fileName] = scene
			
		var instance = scene.instance()
		instance.position = coords * roomSizeVector
		
		add_child(instance)
	
	var playerInstance = player.instance()
	var roomMiddle = ROOM_SIZE / 2 + 8
	playerInstance.position = Vector2(roomMiddle, roomMiddle)
	
	add_child(playerInstance)

func makeRealm(criticalPathLength):
	# using this while loop for now to safeguard against the big
	# TODO case - where the algorithm corners itself. Since it's
	# so rare, randomly trying again is probably fine .. forever
	var realm = null
	
	while !realm:
		realm = $CriticalPathMaker.makeCriticalPath(criticalPathLength)
  
	# extend the non-critical-path paths a little to throw the player off
	# for now it is possible that there are no branches off the critical path
	# so skip this part if that's the case
	var numNeededRooms = realm.neededRooms.size()
	if numNeededRooms:
		realm = $Fluffer.addFluff(floor(criticalPathLength / 2), realm.rooms, realm.neededRooms)

	# dead-end or loop back all the loose ends
	return $Filler.fillNeededRooms(realm.rooms, realm.neededRooms)
