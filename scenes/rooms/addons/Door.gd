extends Area2D

func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == 'Player':
		Functions._on_door_entered()