extends MarginContainer

signal enter_shop
signal enter_lair

func _ready():
	pass

func _on_Monastery_pressed():
	emit_signal('enter_shop')


func _on_Cave_pressed():
	PlayerStore.change_scene('lair/LairRoom')


func _on_Farm_pressed():
	PlayerStore.change_scene('inventory/Equipment')
