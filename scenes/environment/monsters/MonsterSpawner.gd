extends Area2D

const BlueSnake = preload("res://scenes/characters/enemy/BlueSnake.tscn")
const Grub = preload("res://scenes/characters/enemy/Grub.tscn")
const YellowSnake = preload("res://scenes/characters/enemy/YellowSnake.tscn")

const Enemies = [BlueSnake, Grub, YellowSnake]

var isStart = false

func _ready():
	if isStart:
		return
	randomize()
	spawn_enemies()

func spawn_enemies():
	var extents = $CollisionShape2D.get_shape().get_extents()
	var left = global_position.x
	var top = global_position.y
	var right = left + extents[0]
	var bottom = top + extents[1]
	
	print(get_global_transform())
	print(top, ' ', left)
	
	var xRange = range(left, right)
	var yRange = range(top, bottom)
	var xCount = xRange.size()
	var yCount = yRange.size()
	
	for i in range(0, randi() % 4):
		var en = Enemies[randi() % 3].instance()
		var x = xRange[randi() % xCount]
		var y = yRange[randi() % yCount]
		Functions._spawn_enemy(en, Vector2(x, y))
