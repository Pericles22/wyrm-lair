extends Node

signal drop_item
signal shoot

func _on_shoot(projectile, position, direction, shooter, dmg):
	var p = projectile.instance()
	p.shooter = shooter
	emit_signal("shoot", p, position, direction, dmg)
	
func _drop_item(drop, position, type):
	emit_signal("drop_item", drop, position, type)