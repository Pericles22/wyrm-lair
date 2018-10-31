extends MarginContainer

signal purchase_item

func _ready():
	pass

func _on_Button_pressed():
	emit_signal('purchase_item')
