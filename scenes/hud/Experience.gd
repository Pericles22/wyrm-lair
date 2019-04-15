extends Control

var Skills = PlayerStore.state.skills
export(String) var stat

func updateXPBar(_skills):
	for _stat in _skills:
		if stat == _stat:
			var val = _skills[_stat].experience / _skills[_stat].requiredXP * 100
			$HBoxContainer/TextureProgress/Tween.interpolate_property($HBoxContainer/TextureProgress, 'value', $HBoxContainer/TextureProgress.value,
			val, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$HBoxContainer/TextureProgress/Tween.start()
			$HBoxContainer/Label.text = String(_skills[_stat].level)

func _ready():
	var val = Skills[stat].experience / Skills[stat].requiredXP * 100
	$HBoxContainer/TextureProgress.value = val
	$HBoxContainer/Label.text = String(Skills[stat].level)
	PlayerStore.connect("updateLevel", self, "updateXPBar")