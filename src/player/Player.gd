extends 'res://nodes/Router.gd'

export(PackedScene) var Inventory

func get_route_scene(node):
  match node:
    'inventory': return Inventory