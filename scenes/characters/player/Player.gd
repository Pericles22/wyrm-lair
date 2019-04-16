extends KinematicBody2D

signal health_changed

const Projectile = preload("res://scenes/projectiles/GreenBolt.tscn")
const Splat = preload("res://scenes/effects/Splat.tscn")
const Hit = preload("res://assets/effects/hit-splat.png")
const Miss = preload("res://assets/effects/miss-splat.png")

var skills = PlayerStore.getStats()

var can_attack = true
var meleeDamage = skills.meleeDamage
var dead = false
var defense = skills.defense
var health = skills.health
var maxHealth = skills.maxHealth
var powered = false
var rangeDamage = skills.rangeDamage
var speed = skills.speed
var target = null
var velocity = Vector2()

func attack():
	var dir = Vector2(1, 0).rotated(global_rotation)
	if target:
		target.take_damage({accuracy = skills.accuracy, damage = skills.meleeDamage}, 'meleeDamage')

func die():
	dead = true
	$AnimatedSprite.queue_free()
	$CollisionShape2D.queue_free()

func shoot():
	var dir = Vector2(1, 0).rotated($AnimatedSprite/Position.global_rotation)
	var attacker = {
		accuracy = skills.accuracy,
		damage = Algorithms.calculate_damage_given(skills.rangeDamage) 
	}
	Functions._on_shoot(Projectile, $AnimatedSprite/Position.global_position, dir, name, attacker)

func take_damage(attacker, type):
	var damage = Algorithms.calculate_damage_taken(attacker, self)
	
	var sp = Splat.instance()
	sp.find_node("Label").text = String(damage)
	if damage:
		sp.texture = Hit
	else:
		sp.texture = Miss
	add_child(sp)
	
	health -= damage
	update_health()
	if health <= 0:
		die()
		
func update_health():
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
	
	velocity = velocity.normalized() * speed
		
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
	
func _ready():
	PlayerStore.connect("updateLevel", self, "update_skills")
	
func set_sprite_dir():
	var target_dir = (get_global_mouse_position() - global_position).normalized()
	$CollisionShape2D.global_rotation = target_dir.angle()
	$AnimatedSprite.global_rotation = target_dir.angle()
	
func update_skills(_skills):
	skills = PlayerStore.getStats()

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
	set_sprite_dir()
	if $AnimatedSprite/AttackRange.is_colliding():
		target = $AnimatedSprite/AttackRange.get_collider()
	else:
		target = null

	velocity = move_and_slide(velocity)
	
func _on_AttackCooldown_timeout():
	can_attack = true


func _on_Button_pressed():
	pass
	var diff = 0
	if powered:
		diff = -10000
		$Button.text = "power"
	else:
		diff = 10000
		$Button.text = "weaken"
	for skill in PlayerStore.state.skills:
		PlayerStore.updateStat(skill, diff)
	powered = !powered
