extends MarginContainer

var equipped = PlayerStore.state.player.equipment
var	equipment = PlayerStore.equipment


func _ready():
	set_armor()


func set_armor():
	for item in equipped:
		if(equipped[item]):
			set_piece(PlayerStore.get_item(equipped[item]))

func set_piece(currItem):
	match currItem.location:
		'strong_hand':
			$VBoxContainer/Armor/RightHand/StrongHand/Image.set_texture(load("res://assets/"+currItem.img))
		'off_hand':
			$VBoxContainer/Armor/LeftHand/OffHand/Image.set_texture(load("res://assets/"+currItem.img))
		'head':
			$VBoxContainer/Armor/Body/Head/Image.set_texture(load("res://assets/"+currItem.img))
		'torso':
			$VBoxContainer/Armor/Body/Torso/Image.set_texture(load("res://assets/"+currItem.img))
		'legs':
			$VBoxContainer/Armor/Body/Legs/Image.set_texture(load("res://assets/"+currItem.img))
		'feet':
			$VBoxContainer/Armor/Body/Feet/Image.set_texture(load("res://assets/"+currItem.img))


func _on_Map_pressed():
	PlayerStore.change_scene('Main')
