extends Node2D

const Realm = preload("res://scenes/realm/Realm.tscn")
var loadNewRealm = true

func _ready():
	Functions.connect("change_realm", self, "clear_realm")

func _process(delta: float):
	if loadNewRealm:
		load_new_realm()
		loadNewRealm = false

func clear_realm():
	print(get_children()[0].name)
	print(get_node("Realm"))
	if get_node("Realm"):
		get_node("Realm").queue_free()
		loadNewRealm = true

func load_new_realm():
	var r = Realm.instance()
	add_child(r)