extends Area2D

var type

func start(pos, t):
	var imagePath = "res://assets/sprites/drops/" + t.image
	var something = load(imagePath)
	$Control/Sprite.texture = something
	position = pos
	type = t

func _on_Drop_body_entered(body):
	if body.name == "Player":
		for stat in type.stats:
			update_player_stats(body, stat, type.stats[stat], type.isPermanent)
			if stat == "health":
				body.update_health()
		queue_free()
		
func update_player_stats(player, stat, diff, perm):
	pass
	#player[stat].experiencew += diff
