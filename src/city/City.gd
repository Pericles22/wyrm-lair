extends MarginContainer

func _on_Blacksmith_pressed():
	RouteStore.assign('/city/equipment-store')


func _on_Cave_pressed():
	RouteStore.assign('/lair')


func _on_Farm_pressed():
	RouteStore.assign('/city/inventory-store')
