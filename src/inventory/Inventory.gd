extends MarginContainer

export(PackedScene) var InventoryItem

func _ready():
	var items = PlayerStore.state.pack
	for item in items:
		var inventoryItem = InventoryItem.instance()
		inventoryItem.find_node('Image').set_texture(load("res://assets/"+items[item].img))
		inventoryItem.find_node('Quantity').text = str(items[item].quantity)
		inventoryItem.connect('equip_item', PlayerStore, 'equip_item', [items[item]])
		$VBoxContainer/ItemRow.add_child(inventoryItem)


func _on_MapButton_pressed():
	PlayerStore.change_scene('Main')