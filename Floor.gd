extends Node2D

const Enemy = preload("res://scenes/characters/Enemy.tscn")

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
	for i in range(1, 31):
		var en = Enemy.instance()
		add_child(en)
		en.position = Vector2(xRange[randi() % xCount], yRange[randi() % yCount])

func _ready():
	set_map_limits()
	set_camera_limits()
	spawn_enemies()

func _on_shoot(projectile, position, direction, shooter, dmg):
	var p = projectile.instance()
	p.shooter = shooter
	add_child(p)
	p.start(position, direction, dmg)
	
func _on_Enemy_drop(drop, position, type):
	var d = drop.instance()
	add_child(d)
	d.start(position, type)
