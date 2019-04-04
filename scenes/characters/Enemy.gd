extends KinematicBody2D

var Player = PlayerStore
var PlayerSkills = Player.state.skills
var drops = Drops.state

const Drop = preload("res://scenes/items/Drop.tscn")
const Projectile = preload("res://scenes/projectiles/BlueSpit.tscn")

export(float) var attack_cooldown = 1
export(int) var attack_radius = 150
export(int) var damage = 10
export(int) var detect_radius = 200
export(float) var hp = 100
export(int) var level = 10
export(int) var speed = 80
export(String) var type = "range"

var attacking = false
var can_attack = true
var is_aggravated = false
var target = null
var velocity = Vector2()

func attack():
	$AnimatedSprite.play('attack')
	if type == "range":
		var dir = Vector2(1, 0).rotated(global_rotation)
		var pos = $Position.global_position
		get_parent()._on_shoot(Projectile, pos, dir, 'Enemy', damage)
	else:
		target.take_damage(damage, '')

func die():
	Player.updateStat('rangeDamage', level * 2)
	randomize()
	get_parent()._on_Enemy_drop(Drop, global_position, drops[drops.keys()[randi()%4]])
	queue_free()
	
func take_damage(damage, pos):
	is_aggravated = true
	var transformer = Transform2D(Vector2(3, 0), Vector2(0, 3), Vector2(0, 0))
	$DetectRadius/CollisionShape2D.set_transform(transformer)
	$AggroCooldown.stop()
	$AggroCooldown.start()
	global_position += pos / 15
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
	$AttackCooldown.wait_time = attack_cooldown
	
func calculate_target_pos():
	var toTarget = target.global_position - global_position

	var a = target.velocity.dot(target.velocity) - 40000;
	var b = 2 * target.velocity.dot(toTarget);
	var c = toTarget.dot(toTarget);
	
	var p = -b / (2 * a);
	var q = sqrt((b * b) - 4 * a * c) / (2 * a);
	
	var t1 = p - q;
	var t2 = p + q;
	var t;
	
	if t1 > t2 && t2 > 0:
	    t = t2;
	else:
	    t = t1;
	
	return target.position + target.velocity * t;
	
func shouldAggro():
	var playerLevel = (PlayerSkills.meleeDamage.level + PlayerSkills.rangeDamage.level + PlayerSkills.magicDamage.level) / 3
	return (level >= playerLevel / 2) || is_aggravated

func _process(delta):
	var current_dir = Vector2(0, 0)
	var targetPosition
	if target:
		targetPosition = calculate_target_pos()
	if target:
		var target_dir = (targetPosition - global_position).normalized()
		current_dir = Vector2(1, 0).rotated($AnimatedSprite.global_rotation)
		global_rotation = target_dir.angle()
	if attacking:
		$AnimatedSprite.play("attack")
		if can_attack && shouldAggro():
			can_attack = false
			attack()
			$AttackCooldown.start()
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

func _on_AggroCooldown_timeout():
	is_aggravated = false
	var reset = Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0))
	$DetectRadius/CollisionShape2D.set_transform(reset)
	pass