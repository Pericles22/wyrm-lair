extends MarginContainer

export(PackedScene) var City
export(PackedScene) var Lair

var state = {
	href = ''
}

func _process(delta):
	var href = RouteStore.href()

	if (href != state.href):
		state.href = href
		__route(href)

func _ready():
	# $City.connect('enter_shop', PlayerStore, 'change_scene', ['shop/Shop'])
	# $City.connect('enter_lair', PlayerStore, 'change_scene', ['fight/Fight'])
	# $HUD.connect('enter_inventory', PlayerStore, 'change_scene', ['inventory/Inventory'])
	pass

func __route(href):
	var nodes = href.split('/')
	nodes.remove(0) # remove the first empty string

	var route = nodes[0]
	$Route.remove_child($Route.get_child(0))

	var scene

	print('routing...', href)

	match route:
		'city': scene = City
		'lair': scene = Lair

	$Route.add_child(scene.instance())