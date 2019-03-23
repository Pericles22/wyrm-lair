extends "res://Floor.gd"

func _ready():
	set_camera_limits()


func _on_Door_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Floor2.tscn")