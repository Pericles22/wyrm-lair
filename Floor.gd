extends Node2D

const BlueSnake = preload("res://scenes/characters/enemy/BlueSnake.tscn")
const Grub = preload("res://scenes/characters/enemy/Grub.tscn")
const YellowSnake = preload("res://scenes/characters/enemy/YellowSnake.tscn")

const Enemies = [BlueSnake, Grub, YellowSnake]

const Particle = preload("res://scenes/items/DropParticles.tscn")

export(int) var enemy_count = 30

export(int) var floorCount
var map_limits
var map_cellsize
var left
var right
var top
var bottom

func set_camera_limits():
	$Player/Camera2D.limit_left = left
	$Player/Camera2D.limit_right = right
	$Player/Camera2D.limit_top = top
	$Player/Camera2D.limit_bottom = bottom
	
func set_map_limits():
	map_limits = $Ground.get_used_rect()
	map_cellsize = $Ground.cell_size
	left = map_limits.position.x * map_cellsize.x
	right = map_limits.end.x * map_cellsize.x
	top = map_limits.position.y * map_cellsize.y
	bottom = map_limits.end.y * map_cellsize.y
	
func spawn_enemies():
	randomize()
	var xRange = range(left, right)
	var yRange = range(top, bottom)
	var xCount = xRange.size()
	var yCount = yRange.size()
	for i in range(1, enemy_count):
		var en = Enemies[randi() % 3].instance()
		en.level = floorCount * 2
		en.position = Vector2(xRange[randi() % xCount], yRange[randi() % yCount])
		add_child(en)

func _ready():
	Functions.connect("drop_item", self, "_on_Enemy_drop")
	Functions.connect("shoot", self, "_on_shoot")
	set_map_limits()
	set_camera_limits()
	spawn_enemies()

func _on_shoot(projectile, position, direction, dmg):
	add_child(projectile)
	projectile.start(position, direction, dmg)
	
func _on_Enemy_drop(drop, position, type):
	var d = drop.instance()
	add_child(d)
	d.start(position, type)
	
func _on_Drop_pickup(pos):
	var p = Particle.instance()
	p.position = pos
	add_child(p)
