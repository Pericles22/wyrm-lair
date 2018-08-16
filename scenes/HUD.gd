extends MarginContainer

signal enter_inventory

func _ready():
	pass

func _on_Inventory_pressed():
	emit_signal('enter_inventory')