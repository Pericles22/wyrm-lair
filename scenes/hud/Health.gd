extends Node2D

var bar_red = preload("res://assets/sprites/hud/health_red.png")
var bar_yellow = preload("res://assets/sprites/hud/health_yellow.png")
var bar_green = preload("res://assets/sprites/hud/health_green.png")
var bar_texture = bar_green

func _ready():
	$TextureProgress.visible = false

func change_health(val):
	$TextureProgress.visible = true
	$Timer.stop()
	$Timer.start()
	if val < 60:
		bar_texture = bar_yellow
	if val < 25:
		bar_texture = bar_red
	$TextureProgress.texture_progress = bar_texture
	$TextureProgress/Tween.interpolate_property($TextureProgress, 'value', $TextureProgress.value,
		val, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$TextureProgress/Tween.start()

func _on_Timer_timeout():
	$TextureProgress.visible = false
