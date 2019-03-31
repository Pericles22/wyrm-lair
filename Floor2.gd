extends "res://Floor.gd"


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Floor1.tscn")
