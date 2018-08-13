extends MarginContainer

export(PackedScene) var ShopItem;

var items = [
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.jpg'
	}
]

func _ready():
	for item in items:
		var shopItem = ShopItem.instance()
		shopItem.set_texture(load("res://assets/"+item.img))
		
		$ItemRow.add_child(shopItem)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
