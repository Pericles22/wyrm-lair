extends Area2D

func start(pos):
	position = pos

func _on_Drop_body_entered(body):
	if body.name == "Player":
		body.speed += 20
		queue_free()
