extends MarginContainer

signal purchase_item
signal equip_item

func _ready():
	pass

func _on_Button_pressed():
	emit_signal('purchase_item')
	$TextureRect/Button.text = 'Equip Item'
