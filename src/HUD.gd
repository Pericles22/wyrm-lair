extends MarginContainer

func _ready():
	pass

func _on_Inventory_pressed():
	print('inventory pressed')
	RouteStore.assign('/player/inventory')