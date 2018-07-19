extends Button

signal do_move;

func _ready():
	pass


func _on_Button_pressed():
	emit_signal('do_move')
