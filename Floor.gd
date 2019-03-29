extends Node2D

func set_camera_limits():
	var map_limits = $Ground.get_used_rect()
	var map_cellsize = $Ground.cell_size
	$Player/Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y
	
func _ready():
	set_camera_limits()
		
func _on_shoot(projectile, position, direction, shooter):
	var p = projectile.instance()
	p.shooter = shooter
	add_child(p)
	p.start(position, direction)
	
func _on_Enemy_drop(drop, position):
	var d = drop.instance()
	add_child(d)
	d.start(position)
