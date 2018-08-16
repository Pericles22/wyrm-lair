extends MarginContainer

export(PackedScene) var InventoryItem

func _ready():
	var items = store.state.pack
	for item in items:
		var inventoryItem = InventoryItem.instance()
		inventoryItem.find_node('Image').set_texture(load("res://assets/"+items[item].img))
		inventoryItem.connect('equip_item', store, 'equip_item', [items[item]])
		$VBoxContainer/ItemRow.add_child(inventoryItem)


func _on_MapButton_pressed():
	get_tree().change_scene('res://Main.tscn')