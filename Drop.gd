extends Area2D

var PlayerState = PlayerStore.state
var type

func start(pos, t):
	var imagePath = "res://assets/sprites/drops/" + t.image
	var something = load(imagePath)
	$Control/Sprite.texture = something
	$Label.text = t.description
	position = pos
	type = t

func _on_Drop_body_entered(body):
	if body.name == "Player":
		for stat in type.stats:
			update_player_stats(body, stat, type.stats[stat], type.isPermanent)
		queue_free()
		
func update_player_stats(player, stat, diff, perm):
	print(stat, diff, perm)
	player[stat] += diff
	if perm:
		PlayerState[stat] += diff
