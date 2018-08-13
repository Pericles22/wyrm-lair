extends Node

var equipment = {
	bronze_dagger = {
		attack = 1,
		speed = 3
	},
	irom_helm = {
		defense = 2,
		speed = -1	
	}
}

var state = {
	player = {
		equipment = {
			head = null,
			body = null,
			legs = null,
			feet = null,
			off_hand = null,
			strong_hand = 'bronze_dagger'
		},
		skills = {
			attack = 618,
			defense = 0,
			magic = 0,
		}
	}
}


func get_attack():
	var weapon = state.player.equipment.strong_hand
	var weapon_attack = 0 if not weapon else weapon.attack
	var attack_skill = get_skill_level('attack')
	
	return attack_skill + weapon_attack


func get_skill_level(name):
	var xp = state.player.skills[name]
	
	if xp == 0:
		return 1
	
	var level_mark = 0
	var level = 0
	
	while level_mark < xp:
		level += 1
		level_mark += 25 + pow(level, 2) / log(level + 1) * 2
	
	return level


func get_state():
	return state