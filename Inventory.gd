extends MarginContainer

func _ready():
	var items = store.pack
	for item in items:
		var inventoryItem = InventoryItem.instance()
		inventoryItem.find_node('Image').set_texture(load("res://assets/"+item.img))
		inventoryItem.find_node('Button').text = 'Equip'
		inventoryItem.connect('equip_item', store, 'equip_item', [item])
		$ItemRow.add_child(inventoryItem)
