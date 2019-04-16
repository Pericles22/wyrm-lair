extends Node

const a = { type = 'a', right = true }
const b = { type = 'b', bottom = true }
const c = { type = 'c', left = true }
const d = { type = 'd', top = true }

const e = { type = 'e', right = true, left = true }
const f = { type = 'f', bottom = true, top = true }

const g = { type = 'g', right = true, top = true }
const h = { type = 'h', right = true, bottom = true }
const i = { type = 'i', bottom = true, left = true }
const j = { type = 'j', left = true, top = true }

const k = { type = 'k', right = true, bottom = true, top = true }
const l = { type = 'l', right = true, bottom = true, left = true }
const m = { type = 'm', bottom = true, left = true, top = true }
const n = { type = 'n', right = true, left = true, top = true }

const o = { type = 'o', right = true, bottom = true, left = true, top = true }

const deadEndRooms = [a, b, c, d]
const pathRooms = [e, f, g, h, i, j, k, l, m, n, o]
const allRooms = deadEndRooms + pathRooms

const RIGHT = 'right'
const BOTTOM = 'bottom'
const LEFT = 'left'
const TOP = 'top'

func getDirectionCoords(coords, direction):
	var x = coords.x
	var y = coords.y
	
	if (direction == RIGHT): return Vector2(x + 1, y)
	if (direction == BOTTOM): return Vector2(x, y + 1)
	if (direction == LEFT): return Vector2(x - 1, y)
	if (direction == TOP): return Vector2(x, y - 1)

func getRoomDirections(roomType, prevRoomDirections):
	var directions = []
  
	if !prevRoomDirections.has(RIGHT) && roomType.has(RIGHT): directions.push_back(RIGHT)
	if !prevRoomDirections.has(BOTTOM) && roomType.has(BOTTOM): directions.push_back(BOTTOM)
	if !prevRoomDirections.has(LEFT) && roomType.has(LEFT): directions.push_back(LEFT)
	if !prevRoomDirections.has(TOP) && roomType.has(TOP): directions.push_back(TOP)
  
	return directions
	
func mergeDictionaries(source1, source2):
	var target = source1.duplicate()
	for key in source2:
		target[key] = source2[key]
		
	return target

func pick(arr):
	if !arr.size():
		return null

	return arr[randi() % arr.size()]

func reverseDirection(direction):
	if (direction == RIGHT): return LEFT
	if (direction == BOTTOM): return TOP
	if (direction == LEFT): return RIGHT
	if (direction == TOP): return BOTTOM
