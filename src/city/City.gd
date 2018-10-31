extends MarginContainer

export(PackedScene) var EquipmentShop
export(PackedScene) var Overview

var route_depth = 0

var state = {
	href = ''
}

func _process(delta):
	var href = RouteStore.href()

	if (href != state.href):
		state.href = href
		__route()

func __route():
	var node = RouteStore.get_route_node(route_depth)
	print('routing in city...', node)

	var scene

	match node:
		'equipment-store': scene = EquipmentShop
		'overview': scene = Overview
		_: scene = Overview

	if !scene: return

	var scene_instance = scene.instance()
	scene_instance.route_depth = route_depth + 1

	$Route.remove_child($Route.get_child(0))
	$Route.add_child(scene_instance)