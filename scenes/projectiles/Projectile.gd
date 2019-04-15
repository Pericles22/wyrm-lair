extends Area2D

var _attacker
export(int) var damage = 10
export(String) var shooter = ''
export(int) var speed = 200
var lifetime = 10

var velocity = Vector2()

func start(_pos, _dir, attacker):
	_attacker = attacker
	position = _pos
	rotation = _dir.angle()
	$Lifetime.wait_time = lifetime
	velocity = _dir * speed
	$Lifetime.start()
	$AnimatedSprite.play('default')
	
func _process(delta):
	position += velocity * delta

func _on_Projectile_body_entered(body):
	if body.name == "Obstacles":
		queue_free()
	elif body.has_method("take_damage") && !(shooter in body.name):
		body.take_damage(_attacker, 'rangeDamage')
		queue_free()

func _on_Lifetime_timeout():
	queue_free()