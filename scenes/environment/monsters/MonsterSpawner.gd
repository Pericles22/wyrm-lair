extends Area2D

const BlueSnake = preload("res://scenes/characters/enemy/BlueSnake.tscn")
const Grub = preload("res://scenes/characters/enemy/Grub.tscn")
const YellowSnake = preload("res://scenes/characters/enemy/YellowSnake.tscn")

const Enemies = [BlueSnake, Grub, YellowSnake]

var floorCount = 2

func _ready():
	randomize()
	spawn_enemies()

func spawn_enemies():
	var extents = $CollisionShape2D.get_shape().get_extents()
	var left = global_position[0]
	var top = global_position[1]
	var right = left + extents[0]
	var bottom = top + extents[1]
	
	var xRange = range(left, right)
	var yRange = range(top, bottom)
	var xCount = xRange.size()
	var yCount = yRange.size()
	
	for i in range(1, 10):
		var en = Enemies[randi() % 3].instance()
		var x = xRange[randi() % xCount]
		var y = yRange[randi() % yCount]
		Functions._spawn_enemy(en, Vector2(x, y))