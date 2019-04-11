extends KinematicBody2D

signal change_health

var Player = PlayerStore
var PlayerSkills = Player.state.skills
var drops = Drops.state

const Drop = preload("res://scenes/items/Drop.tscn")
const Projectile = preload("res://scenes/projectiles/BlueSpit.tscn")

export(float) var attack_cooldown = .2
export(int) var attack_radius = 150
export(int) var damage = 10
export(int) var defense = 4
export(int) var detect_radius = 200
export(float) var hp = 10
export(int) var level
export(int) var speed = 80
export(String) var type = "range"

var attacking = false
var can_attack = true
var is_aggravated = false
var max_health = hp
var target = null
var velocity = Vector2()

func attack():
	$AnimatedSprite.play('attack')
	if type == "range":
		var dir = Vector2(1, 0).rotated($AnimatedSprite/Position.global_rotation)
		var pos = $AnimatedSprite/Position.global_position
		get_parent()._on_shoot(Projectile, pos, dir, 'Enemy', damage)
	else:
		target.take_damage(damage, '')

func die():
	Player.updateStat('rangeDamage', level * 2)
	randomize()
	get_parent()._on_Enemy_drop(Drop, global_position, drops[drops.keys()[randi()%4]])
	queue_free()
	
func take_damage(attacker):
	var damage = Algorithms.calculate_damage_taken(attacker, self)
	is_aggravated = true
	var transformer = Transform2D(Vector2(3, 0), Vector2(0, 3), Vector2(0, 0))
	$DetectRadius/CollisionShape2D.set_transform(transformer)
	$Damage.text = String(damage)
	$Damage.visible = true
	$AggroCooldown.stop()
	$AggroCooldown.start()
	$ShowDamage.stop()
	$ShowDamage.start()
	hp -= damage
	
	emit_signal("change_health", hp * 100 / max_health)
	
	if hp <= 0:
		die()

func _ready():
	var circle1 = CircleShape2D.new()
	var circle2 = CircleShape2D.new()
	$AnimatedSprite/RayCast2D.cast_to = Vector2(0, attack_radius)
	$AttackRadius/CollisionShape2D.shape = circle1
	$AttackRadius/CollisionShape2D.shape.radius = attack_radius
	$DetectRadius/CollisionShape2D.shape = circle2
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius
	$AttackCooldown.wait_time = attack_cooldown
	$Damage.visible = false
	
func shouldAggro():
	var playerLevel = (PlayerSkills.meleeDamage.level + PlayerSkills.rangeDamage.level + PlayerSkills.magicDamage.level) / 3
	return (level >= playerLevel / 2) || is_aggravated

func _process(delta):
	var collider = ''
	if $AnimatedSprite/RayCast2D.get_collider():
		collider = $AnimatedSprite/RayCast2D.get_collider().name
	var current_dir = Vector2(0, 0)
	var targetPosition
	if target:
		targetPosition = Algorithms.calculate_target_pos(target, global_position)
		var target_dir = (targetPosition - global_position).normalized()
		current_dir = Vector2(1, 0).rotated($AnimatedSprite.global_rotation)
		$AnimatedSprite.global_rotation = target_dir.angle()
		$CollisionShape2D.global_rotation = target_dir.angle()
		$AnimatedSprite/Position.global_rotation = target_dir.angle()
	if attacking && !("Obstacles" in collider):
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


func _on_ShowDamage_timeout():
	$Damage.visible = false