extends Node2D

func _ready():
	$City.connect('enter_shop', PlayerStore, 'change_scene', ['shop/Shop'])
	$City.connect('enter_lair', PlayerStore, 'change_scene', ['fight/Fight'])
	$HUD.connect('enter_inventory', PlayerStore, 'change_scene', ['inventory/Inventory'])
