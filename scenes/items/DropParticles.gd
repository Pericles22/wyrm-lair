extends Particles2D

func _ready():
	print('begunified')
	emitting = true
	$Timer.wait_time = self.lifetime * 2
	$Timer.start()

func _on_Timer_timeout():
	queue_free()
