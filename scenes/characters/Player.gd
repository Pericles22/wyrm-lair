extends KinematicBody2D

signal health_changed

const Projectile = preload("res://scenes/projectiles/GreenBolt.tscn")
var skills = PlayerStore.getStats()

var can_attack = true
var meleeDamage = skills.meleeDamage
var dead = false
var health = skills.health
var maxHealth = skills.maxHealth
var rangeDamage = skills.rangeDamage
var show_health = false
var speed = skills.speed
var target = null
var velocity = Vector2()

func attack():
	var dir = Vector2(1, 0).rotated(global_rotation)
	if target:
		target.take_damage(meleeDamage, dir)

func die():
	dead = true
	$AnimatedSprite.queue_free()
	$CollisionShape2D.queue_free()

func shoot():
	var dir = Vector2(1, 0).rotated($Position.global_rotation)
	get_parent()._on_shoot(Projectile, $Position.global_position, dir, name, rangeDamage)

func take_damage(damage, pos):
	health -= damage
	update_health()
	if health <= 0:
		die()
		
func update_health():
	$HUD.visible = true
	$HealthCooldown.stop()
	$HealthCooldown.start()
	emit_signal("health_changed", health * 100 / maxHealth)

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
			$AttackCooldown.start()
			attack()
	elif Input.is_action_just_pressed("shoot"):
		if can_attack:
			can_attack = false
			$AttackCooldown.start()
			shoot()

func clamp_pos():
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right)
	position.y = clamp(position.y, $Camera2D.limit_top, $Camera2D.limit_bottom)
	
func set_sprite_dir(delta):
	var target_dir = (get_global_mouse_position() - global_position).normalized()
	var current_dir = Vector2(1, 0).rotated(global_rotation)
	$CollisionShape2D.global_rotation = target_dir.angle()
	$Position.global_rotation = target_dir.angle()
	$AnimatedSprite.global_rotation = target_dir.angle()

func _ready():
	health = maxHealth
	emit_signal("health_changed", health * 100 / maxHealth)
	$HUD.visible = false

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
	if $AnimatedSprite/AttackRange.is_colliding():
		target = $AnimatedSprite/AttackRange.get_collider()
	else:
		target = null

	velocity = move_and_slide(velocity)
	
func _on_AttackCooldown_timeout():
	can_attack = true

func _on_HealthCooldown_timeout():
	$HUD.visible = false
