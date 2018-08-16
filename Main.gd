extends Node2D

func _ready():
	$City.connect('enter_shop', self, 'enter_shop')
	$City.connect('enter_lair', self, 'enter_lair')
	$HUD.connect('enter_inventory', self, 'enter_inventory')
	print('the level:', store.get_stat_level('attack'))
	
func enter_shop():
	get_tree().change_scene('res://Shop.tscn')
	
func enter_lair():
	get_tree().change_scene('res://Fight.tscn')
	
func enter_inventory():
	get_tree().change_scene('res://Inventory.tscn')
