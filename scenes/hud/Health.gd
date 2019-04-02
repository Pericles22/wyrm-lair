extends Node2D

var bar_red = preload("res://assets/sprites/hud/health_red.png")
var bar_yellow = preload("res://assets/sprites/hud/health_yellow.png")
var bar_green = preload("res://assets/sprites/hud/health_green.png")
var bar_texture = bar_green

func change_health(val):
	if val < 60:
		bar_texture = bar_yellow
	if val < 25:
		bar_texture = bar_red
	$TextureProgress.texture_progress = bar_texture
	$TextureProgress/Tween.interpolate_property($TextureProgress, 'value', $TextureProgress.value,
		val, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$TextureProgress/Tween.start()


func _on_Player_health_changed():
	pass # Replace with function body.
