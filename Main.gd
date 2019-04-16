extends Node2D

const Floor = preload("res://scenes/realm/Realm.tscn")

func _ready():
	Functions.connect("change_floor", self, "new_floor")
	new_floor()

func new_floor():
	if find_node("Realm"):
		find_node("Realm").queue_free()
	var f = Floor.instance()
	add_child(f)
	print(get_children()[0].name)