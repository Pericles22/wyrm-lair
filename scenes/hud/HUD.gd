extends CanvasLayer

var Skills = PlayerStore.state.skills

func thingy(level, stat):
	var value = 0
	if stat == 'magicDamage':
		value = Skills.magicDamage.experience / Skills.magicDamage.requiredXP
	elif stat == 'meleeDamage':
		value = Skills.meleeDamage.experience / Skills.meleeDamage.requiredXP
	elif stat == 'rangeDamage':
		value = Skills.rangeDamage.experience / Skills.rangeDamage.requiredXP
	
	$MarginContainer/HBoxContainer/VBoxContainer.find_node(stat).find_node('Tween').interpolate_propery($MarginContainer/HBoxContainer/VBoxContainer.find_node(stat), 'value', $MarginContainer/HBoxContainer/VBoxContainer.find_node(stat).value, value, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$MarginContainer/HBoxContainer/VBoxContainer.find_node(stat).find_node('Tween').start()
	

func _ready():
	PlayerStore.connect("updateLevel", self, "thingy")
