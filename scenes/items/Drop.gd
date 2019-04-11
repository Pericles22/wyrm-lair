extends Area2D

const Parts = preload("res://scenes/items/DropParticles.tscn")
var type

func start(pos, t):
	var imagePath = "res://assets/sprites/drops/" + t.image
	var image = load(imagePath)
	$Control/Sprite.texture = image
	position = pos
	type = t

func _on_Drop_body_entered(body):
	if body.name == "Player":
		print('here')
		get_parent()._on_Drop_pickup(global_position)
		queue_free()
		
func update_player_stats(player, stat, diff, perm):
	if(player && stat && diff && perm):
		pass
