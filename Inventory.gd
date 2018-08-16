extends MarginContainer

export(PackedScene) var InventoryItem

func _ready():
	var items = store.state.pack
	for item in items:
		var inventoryItem = InventoryItem.instance()
		inventoryItem.find_node('Image').set_texture(load("res://assets/"+items[item].img))
		inventoryItem.connect('equip_item', store, 'equip_item', [items[item]])
		$ItemRow.add_child(inventoryItem)
