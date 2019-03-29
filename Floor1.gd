extends "res://Floor.gd"

func _on_Door_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Floor2.tscn")
