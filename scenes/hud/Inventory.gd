extends Control

const Button = preload("res://scenes/hud/CatButton.tscn")
const Panel = preload("res://scenes/hud/Panel.tscn")

func set_items(filtered):
	for child in $MarginContainer/VBoxContainer/Rows.get_children():
		child.queue_free()
	var playerInv = PlayerStore.state.inventory
	for el in playerInv:
		if filtered.get(el):
			var piece = filtered[el]
			var image = load("res://assets/equipment/" + piece.image)
			var p = Panel.instance()
			p.find_node("CenterContainer").find_node("TextureRect").texture = image
			$MarginContainer/VBoxContainer/Rows.add_child(p)
	

func _ready():
	Equipment.connect("filter_updated", self, "set_items")
	
	for cat in Equipment.categories:
		var b = Button.instance()
		b.text = ' ' + cat + ' '
		$MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer.add_child(b)
		
	set_items(Equipment.filtered_items)