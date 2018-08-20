extends Node2D

func _ready():
	$City.connect('enter_shop', store, 'change_scene', ['Shop'])
	$City.connect('enter_lair', store, 'change_scene', ['Fight'])
	$HUD.connect('enter_inventory', store, 'change_scene', ['Inventory'])
