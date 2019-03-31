extends KinematicBody2D

const Drop = preload("res://Drop.tscn")
const Projectile = preload("res://Projectile.tscn")

export(float) var attack_cooldown
export(int) var attack_radius
export(int) var damage
export(int) var detect_radius
export(float) var hp
export(int) var range_radius
export(int) var speed
export(String) var type = "range"

var attacking = false
var can_attack = true
var target = null
var velocity = Vector2()

func attack():
	if type == "range":
		var dir = Vector2(1, 0).rotated(global_rotation)
		var pos = $Position.global_position
		get_parent()._on_shoot(Projectile, pos, dir, 'Enemy')
	else:
		target.take_damage(damage, '')

func die():
	get_parent()._on_Enemy_drop(Drop, global_position)
	queue_free()
	
func take_damage(damage, pos):
	global_position -= (pos - global_position)
	hp -= damage
	if hp <= 0:
		die()

func _ready():
	var circle1 = CircleShape2D.new()
	var circle2 = CircleShape2D.new()
	$AttackRadius/CollisionShape2D.shape = circle1
	$AttackRadius/CollisionShape2D.shape.radius = attack_radius
	$DetectRadius/CollisionShape2D.shape = circle2
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	$Cooldown.wait_time = attack_cooldown

func _process(delta):
	var current_dir = Vector2(0, 0)
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		current_dir = Vector2(1, 0).rotated($AnimatedSprite.global_rotation)
		global_rotation = target_dir.angle()
	if attacking:
		$AnimatedSprite.play("attack")
		if can_attack:
			can_attack = false
			attack()
			$Cooldown.start()
	elif target:
		$AnimatedSprite.play("move")
		velocity = current_dir * speed
		velocity = move_and_slide(velocity)
	else:
		$AnimatedSprite.play("idle")

func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		target = body
	
func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null

func _on_AttackRadius_body_entered(body):
	if target && body == target:
		attacking = true

func _on_AttackRadius_body_exited(body):
	if !target || body == target:
		attacking = false

func _on_Cooldown_timeout():
	can_attack = true