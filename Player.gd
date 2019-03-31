extends KinematicBody2D

signal health_changed

const Projectile = preload("res://Projectile.tscn")
var state = PlayerStore.state

var can_attack = true
var damage = state.damage
var dead = false
var health = state.health
var maxHealth = state.maxHealth
export(int) var rangeDamage = state.rangeDamage
export(int) var speed = state.speed
var target = null
var velocity = Vector2()

func attack():
	if target:
		target.take_damage(damage, global_position)

func die():
	dead = true
	$AnimatedSprite.queue_free()
	$CollisionShape2D.queue_free()

func shoot():
	var dir = Vector2(1, 0).rotated($Position.global_rotation)
	get_parent()._on_shoot(Projectile, $Position.global_position, dir, name, rangeDamage)

func take_damage(damage, pos):
	health -= damage
	emit_signal("health_changed", health * 100 / maxHealth)
	if health <= 0:
		die()

func check_inputs():
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
	else:
		velocity.y = 0
		
	if Input.is_action_just_pressed("attack"):
		if can_attack && !!target:
			can_attack = false
			$Cooldown.start()
			attack()
	elif Input.is_action_just_pressed("shoot"):
		if can_attack:
			can_attack = false
			$Cooldown.start()
			shoot()

func clamp_pos():
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right)
	position.y = clamp(position.y, $Camera2D.limit_top, $Camera2D.limit_bottom)
	
func set_sprite_dir(delta):
	var target_dir = (get_global_mouse_position() - global_position).normalized()
	var current_dir = Vector2(1, 0).rotated(global_rotation)
	global_rotation = target_dir.angle()

func _ready():
	health = maxHealth
	emit_signal("health_changed", health * 100 / maxHealth)

func _physics_process(delta):
	if dead:
		return
	check_inputs()
	if(!can_attack):
		$AnimatedSprite.play("attack")
	elif(velocity.y or velocity.x):
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	clamp_pos()
	set_sprite_dir(delta)
	if $AttackRange.is_colliding():
		target = $AttackRange.get_collider()
	else:
		target = null
		
	velocity = move_and_slide(velocity)
	if state.speed != speed:
		state.speed = speed
	
func _on_Cooldown_timeout():
	can_attack = true
