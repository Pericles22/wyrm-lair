extends 'res://nodes/Router.gd'

export(PackedScene) var EquipmentShop
export(PackedScene) var Overview

func get_route_scene(node):
	match node:
		'equipment-store': return EquipmentShop
		'overview': return Overview
		_: return Overview