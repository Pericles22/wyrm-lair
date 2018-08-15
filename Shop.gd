extends MarginContainer

export(PackedScene) var ShopItem;

var items = [
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	},
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		img = 'rusty_sword.png'
	}
]

func _ready():
	var num = 0
	for item in items:
		var shopItem = ShopItem.instance()
		shopItem.find_node('Image').set_texture(load("res://assets/"+item.img))
		$ItemRow.add_child(shopItem)
		num += 1


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
