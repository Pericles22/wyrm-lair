extends Particles2D

func _ready():
	$Lifetime.start()

func _on_Lifetime_timeout():
	queue_free()