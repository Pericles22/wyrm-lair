extends 'res://nodes/Router.gd'

func _ready():
	pass

func on_route():
	var first_node = RouteStore.get_route_node(0)

	# We have 4 possible HUD buttons: Back, Map, Player, and Retreat
	# Can maybe clean up this logic with a state machine :O
	# ...or just define routes for these layouts and ditch this function...
	match first_node:
		'city':
			$Row/Map.hide()
			$Row/Player.show()
			$Row/Retreat.hide()

			var second_node = RouteStore.get_route_node(1)

			# No back button at the root-level city overview
			if (!second_node || second_node == 'overview'):
				$Row/Back.hide()
			else:
				$Row/Back.show()
		'fight':
			$Row/Back.hide()
			$Row/Map.hide()
			$Row/Player.hide()
			$Row/Retreat.show()
		'lair':
			$Row/Back.hide()
			$Row/Map.show()
			$Row/Player.show()
			$Row/Retreat.hide()
		'player':
			$Row/Back.show()
			$Row/Map.hide()
			$Row/Player.hide()
			$Row/Retreat.hide()


func _on_Back_pressed():
	print('going back!')
	RouteStore.back()

func _on_Map_pressed():
	print('Map pressed!')
	RouteStore.replace('/city')

func _on_Player_pressed():
	print('Player pressed!')
	RouteStore.assign('/player/inventory')

func _on_Retreat_pressed():
	print('retreating!')
	# TODO: FightStore.retreat() or something