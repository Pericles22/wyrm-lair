extends Node

var state = {
	currentFloor = 1,
	realm = "farm"
}

func _increment_floor():
	state.currentFloor += 1
