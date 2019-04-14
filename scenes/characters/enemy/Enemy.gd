extends KinematicBody2D

signal change_health

var Player = PlayerStore
var PlayerSkills = Player.state.skills
var drops = Drops.state

const Drop = preload("res://scenes/items/Drop.tscn")
const Projectile = preload("res://scenes/projectiles/BlueSpit.tscn")
const Splat = preload("res://scenes/effects/Splat.tscn")
const Hit = preload("res://assets/effects/hit-splat.png")
const Miss = preload("res://assets/effects/miss-splat.png")


var accuracy
var attack_cooldown
var attack_radius
var damage
var defense
var detect_radius
var hp
var level
var max_health
var speed
var type

var attacking = false
var can_attack = true
var is_dead = false
var is_aggravated = false
var target = null
var velocity = Vector2()

func attack():
	$AnimatedSprite.play('attack')
	if type == "range":
		var dir = Vector2(1, 0).rotated($CollisionShape2D/Position.global_rotation)
		var pos = $CollisionShape2D/Position.global_position
		get_parent()._on_shoot(Projectile, pos, dir, 'Enemy', self)
	else:
		target.take_damage(self)

func die():
	$Particles2D.emitting = true
	is_dead = true
	Player.updateStat('rangeDamage', level * 2)
	randomize()
	$AnimatedSprite.queue_free()
	$CollisionShape2D.queue_free()
	get_parent()._on_Enemy_drop(Drop, global_position, drops[drops.keys()[randi()%4]])
	$DeathTimer.start()
	
func get_type():
	randomize()
	var t
	var n = randi() % 3
	if n == 2:
		attack_radius = 150
		detect_radius = 200
		type = 'range'
	elif n == 1:
		attack_radius = 40
		detect_radius = 150
		type = 'melee'
	else:
		attack_radius = 130
		detect_radius = 180
		type = 'range'
		
func has_clear_shot():
	var collider1 = ''
	var collider2 = ''
	if $CollisionShape2D/AtFuturePos.get_collider():
		collider1 = $CollisionShape2D/AtFuturePos.get_collider().name
	if $AtCurrentPos/RayCast2D.get_collider():
		collider2 = $AtCurrentPos/RayCast2D.get_collider().name
	return !("Obstacles" in collider1) || !("Obstacles" in collider2)
	
func set_stats():
	var currFloor = get_parent().floorCount
	accuracy = 20 + (currFloor * rand_range(.9, 1.1))
	attack_cooldown = 1 - (currFloor * .01)
	damage = 10 + (currFloor * rand_range(.9, 1.1))
	defense = 5 + (currFloor * rand_range(.9, 1.1))
	hp = 10 + (currFloor * rand_range(.9, 1.1))
	level = floor(currFloor * rand_range(.9, 1.1))
	max_health = hp
	speed = 60 + (currFloor * rand_range(.9, 1.1))
	
	get_type()
	
func take_damage(attacker):
	if is_dead:
		return
	var damage = Algorithms.calculate_damage_taken(attacker, self)
	is_aggravated = true
	var transformer = Transform2D(Vector2(3, 0), Vector2(0, 3), Vector2(0, 0))
	$DetectRadius/CollisionShape2D.set_transform(transformer)
	$AggroCooldown.stop()
	$AggroCooldown.start()
	hp -= damage
	var sp = Splat.instance()
	sp.find_node("Label").text = String(damage)
	if damage:
		sp.texture = Hit
	else:
		sp.texture = Miss
	add_child(sp)
	
	emit_signal("change_health", hp * 100 / max_health)
	
	if hp <= 0:
		die()

func _ready():
	set_stats()
	var circle1 = CircleShape2D.new()
	var circle2 = CircleShape2D.new()
	$CollisionShape2D/AtFuturePos.cast_to = Vector2(0, attack_radius)
	$AtCurrentPos/RayCast2D.cast_to = Vector2(0, attack_radius)
	$AttackRadius/CollisionShape2D.shape = circle1
	$AttackRadius/CollisionShape2D.shape.radius = attack_radius
	$DetectRadius/CollisionShape2D.shape = circle2
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	$AttackCooldown.wait_time = attack_cooldown
	
func shouldAggro():
	var playerLevel = (PlayerSkills.meleeDamage.level + PlayerSkills.rangeDamage.level + PlayerSkills.magicDamage.level) / 3
	print(playerLevel, " ", level)
	return (level >= playerLevel / 2) || is_aggravated

func _process(delta):
	if is_dead:
		return
	
	var current_dir = Vector2(0, 0)
	var targetPosition
	if target:
		targetPosition = Algorithms.calculate_target_pos(target, global_position)
		var currentTargetPosition = target.global_position
		var target_dir = (targetPosition - global_position).normalized()
		var current_target_dir = (currentTargetPosition - global_position).normalized()
		current_dir = Vector2(1, 0).rotated($AnimatedSprite.global_rotation)
		$AnimatedSprite.global_rotation = target_dir.angle()
		$AtCurrentPos.global_rotation = current_target_dir.angle()
		$CollisionShape2D.global_rotation = target_dir.angle()
	if attacking && has_clear_shot():
		$AnimatedSprite.play("attack")
		if can_attack && shouldAggro():
			can_attack = false
			attack()
			$AttackCooldown.start()
	elif target :
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

func _on_AggroCooldown_timeout():
	is_aggravated = false
	var reset = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0))
	$DetectRadius/CollisionShape2D.set_transform(reset)
	pass

func change_health():
	pass

func _on_DeathTimer_timeout():
	queue_free()