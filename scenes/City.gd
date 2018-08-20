extends MarginContainer

signal enter_shop
signal enter_lair

func _ready():
	pass

func _on_Monastery_pressed():
	emit_signal('enter_shop')


func _on_Cave_pressed():
	store.change_scene('LairRoom')


func _on_Farm_pressed():
	get_tree().change_scene('res://Equipment.tscn')
