extends MarginContainer

signal equip_item

func _ready():
	pass

func _on_Equip_pressed():
	print('first step')
	emit_signal('equip_item')
