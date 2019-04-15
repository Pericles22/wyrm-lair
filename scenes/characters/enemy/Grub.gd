extends "res://scenes/characters/enemy/Enemy.gd"

func _ready():
	attack_radius = 20
	detect_radius = 100
	type = 'melee'
	start()
	