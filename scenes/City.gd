extends MarginContainer

signal enter_shop
signal enter_lair

func _ready():
	pass

func _on_Monastery_pressed():
	emit_signal('enter_shop')


func _on_Cave_pressed():
	emit_signal('enter_lair')
