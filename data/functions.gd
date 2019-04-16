extends Node

signal change_realm
signal drop_item
signal shoot

func _on_shoot(projectile, position, direction, shooter, dmg):
	var p = projectile.instance()
	p.shooter = shooter
	emit_signal("shoot", p, position, direction, dmg)
	
func _drop_item(drop, position, type):
	emit_signal("drop_item", drop, position, type)
	
func _on_door_entered():
	print('entered')
	emit_signal("change_realm")