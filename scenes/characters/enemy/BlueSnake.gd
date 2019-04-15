extends "res://scenes/characters/enemy/Enemy.gd"

func _ready():
	attack_radius = 140
	detect_radius = 180
	type = 'range'
	start()
	