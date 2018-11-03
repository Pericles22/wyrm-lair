extends 'res://nodes/Router.gd'

export(PackedScene) var City
export(PackedScene) var Fight
export(PackedScene) var Lair
export(PackedScene) var Player

func _ready():
	# $City.connect('enter_shop', PlayerStore, 'change_scene', ['shop/Shop'])
	# $City.connect('enter_lair', PlayerStore, 'change_scene', ['fight/Fight'])
	# $HUD.connect('enter_inventory', PlayerStore, 'change_scene', ['inventory/Inventory'])
	pass

func get_route_scene(node):
	match node:
		'city': return City
		'fight': return Fight
		'lair': return Lair
		'player': return Player