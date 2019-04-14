extends Control

var Skills = PlayerStore.state.skills
export(String) var stat

func thingy(level, _stat):
	var val = Skills[_stat].experience / Skills[_stat].requiredXP * 100
	
	print(stat, _stat)
	
	if stat == _stat:
		$HBoxContainer/TextureProgress/Tween.interpolate_property($HBoxContainer/TextureProgress, 'value', $HBoxContainer/TextureProgress.value,
		val, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$HBoxContainer/TextureProgress/Tween.start()

func _ready():
	var val = Skills[stat].experience / Skills[stat].requiredXP * 100
	print(val)
	$HBoxContainer/TextureProgress.value = val
	PlayerStore.connect("updateLevel", self, "thingy")