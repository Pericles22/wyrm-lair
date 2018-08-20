extends MarginContainer

signal equip_item

func _ready():
	pass

func _on_Equip_pressed():
	emit_signal('equip_item')
