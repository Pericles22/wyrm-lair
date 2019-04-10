extends Control

func thingy(level):
	$MarginContainer/HBoxContainer/Label.text = 'Level: ' + String(level)

func _ready():
	$MarginContainer/HBoxContainer/Label.text = 'Level: ' + String(PlayerStore.state.skills.rangeDamage.level)
	PlayerStore.connect("updateLevel", self, "thingy")
