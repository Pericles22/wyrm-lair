extends MarginContainer

export(PackedScene) var ShopItem;

var items = store.equipment

func _ready():
	for item in items:
		var shopItem = ShopItem.instance()
		shopItem.find_node('Image').set_texture(load("res://assets/"+item.img))
		shopItem.connect('purchase_item', self, 'purchase_item', [item])
		$ItemRow.add_child(shopItem)
		
func purchase_item(item):
	print('I am here')
	
	if(store.get_gold() < item.cost):
		print('insufficient funds')
	else:
		store.purchase_item(item)
