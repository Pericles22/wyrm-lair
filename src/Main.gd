extends MarginContainer

export(PackedScene) var City
export(PackedScene) var Fight
export(PackedScene) var Lair

var route_depth = 0

var state = {
	href = ''
}

func _process(delta):
	var href = RouteStore.href()

	if (href != state.href):
		state.href = href
		__route()

func _ready():
	# $City.connect('enter_shop', PlayerStore, 'change_scene', ['shop/Shop'])
	# $City.connect('enter_lair', PlayerStore, 'change_scene', ['fight/Fight'])
	# $HUD.connect('enter_inventory', PlayerStore, 'change_scene', ['inventory/Inventory'])
	pass

func __route():
	var node = RouteStore.get_route_node(route_depth)
	print('routing in Main...', node)

	var scene

	match node:
		'city': scene = City
		'fight': scene = Fight
		'lair': scene = Lair

	if !scene: return

	var scene_instance = scene.instance()
	scene_instance.route_depth = route_depth + 1

	$Route.remove_child($Route.get_child(0))
	$Route.add_child(scene_instance)