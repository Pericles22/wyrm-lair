extends Node

signal change_realm
signal drop_item
signal drop_pickup
signal shoot
signal spawn_enemy


func _on_door_entered():
	Common._increment_floor()
	emit_signal("change_realm")
	
func _drop_item(drop, position, type):
	emit_signal("drop_item", drop, position, type)

func _on_drop_pickup(pos):
	emit_signal("drop_pickup", pos)
	
func _on_shoot(projectile, position, direction, shooter, dmg):
	var p = projectile.instance()
	p.shooter = shooter
	emit_signal("shoot", p, position, direction, dmg)
	
func _spawn_enemy(en, pos):
	emit_signal("spawn_enemy", en, pos)