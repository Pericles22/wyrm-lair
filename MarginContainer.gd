extends MarginContainer

var equipped = store.state.player.equipment
var	equipment = store.equipment


func _ready():
	set_armor()


func set_armor():
	for item in equipped:
		if(equipped[item]):
			set_piece(store.get_item(equipped[item]))

func set_piece(currItem):
	match currItem.location:
		'strong_hand':
			$HBoxContainer/RightHand/StrongHand/Image.set_texture(load("res://assets/"+currItem.img))
		'off_hand':
			$HBoxContainer/LeftHand/OffHand/Image.set_texture(load("res://assets/"+currItem.img))
		'head':
			$HBoxContainer/Body/Head/Image.set_texture(load("res://assets/"+currItem.img))
		'torso':
			$HBoxContainer/Body/Torso/Image.set_texture(load("res://assets/"+currItem.img))
		'legs':
			$HBoxContainer/Body/Legs/Image.set_texture(load("res://assets/"+currItem.img))
		'feet':
			$HBoxContainer/Body/Feet/Image.set_texture(load("res://assets/"+currItem.img))
