extends KinematicBody2D

export(float) var attack_cooldown
export(int) var attack_radius
export(int) var damage
export(int) var detect_radius
export(float) var hp
export(int) var speed

var attacking = false
var can_attack = true
var target = null
var velocity = Vector2()

func die():
	queue_free()

func take_damage(damage, pos):
	$Cooldown.stop()
	can_attack = true
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
	if attacking:
		$AnimatedSprite.play("attack")
		if can_attack:
			can_attack = false
			$Cooldown.start()
	elif target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1, 0).rotated($AnimatedSprite.global_rotation)
		global_rotation = target_dir.angle()
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
	$Cooldown.stop()
	if !target || body == target:
		attacking = false

func _on_Cooldown_timeout():
	can_attack = true
	if attacking:
		target.take_damage(damage)