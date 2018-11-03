extends 'res://nodes/Router.gd'

export(PackedScene) var ShopItem;

var items = PlayerStore.equipment

func _ready():
	for item in items:
		var shopItem = ShopItem.instance()
		shopItem.find_node('Image').set_texture(load("res://assets/"+items[item].img))
		shopItem.connect('purchase_item', self, 'purchase_item', [items[item]])
		$VBoxContainer/ItemRow.add_child(shopItem)
		
func purchase_item(item):
	if(PlayerStore.get_gold() < item.cost):
		print('insufficient funds')
	else:
		PlayerStore.purchase_item(item)

func _on_MapButton_pressed():
	RouteStore.assign('/city')
