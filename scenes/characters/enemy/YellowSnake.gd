extends "res://scenes/characters/enemy/Enemy.gd"

func _ready():
	attack_radius = 120
	detect_radius = 150
	type = 'range'
	start()
	