extends MarginContainer

export(PackedScene) var ShopItem;

var items = store.equipment

func _ready():
	var num = 0
	for item in items:
		var shopItem = ShopItem.instance()
		shopItem.find_node('Image').set_texture(load("res://assets/"+item.img))
		shopItem.connect('purchase_item', store, 'purchase_item', [item])
		$ItemRow.add_child(shopItem)
		num += 1

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
