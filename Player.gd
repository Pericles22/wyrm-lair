extends KinematicBody2D

signal health_changed

var can_attack = true
var damage = 20
var speed = 120
var velocity = Vector2()
var max_health = 100
var lastPos = Vector2()
var target = null
var health

func attack():
	if target:
		target.take_damage(damage, global_position)

func die():
	queue_free()

func take_damage(damage):
	health -= damage
	emit_signal("health_changed", health * 100 / max_health)
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
			velocity = Vector2(0, 0)
			$Cooldown.start()

func clamp_pos():
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right)
	position.y = clamp(position.y, $Camera2D.limit_top, $Camera2D.limit_bottom)
	
func set_sprite_dir(delta):
	var target_dir = (get_global_mouse_position() - global_position).normalized()
	var current_dir = Vector2(1, 0).rotated(global_rotation)
	global_rotation = current_dir.linear_interpolate(target_dir, speed * delta).angle()
	lastPos = global_position
	
func _ready():
	health = max_health
	emit_signal("health_changed", health * 100 / max_health)

func _physics_process(delta):
	check_inputs()
	if(!can_attack):
		velocity = Vector2(0, 0)
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
	
func _on_Cooldown_timeout():
	can_attack = true
	attack()
