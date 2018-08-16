extends Node

var equipment = [
	{
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		location = 'head',
		img = 'iron_helm.png'
	},
	{
		name = 'rusty_sword',
		stats = {
			offense = 3,
			speed = 1	
		},
		location = 'strong_hand',
		img = 'rusty_sword.png'
	}
]

var state = {
	player = {
		maxHealth = 200,
		currHealth = 200,
		moves = ['slash','harden'],
		equipment = {
			head = null,
			body = null,
			legs = null,
			feet = null,
			off_hand = null,
			strong_hand = null
		},
		stats = {
			attack = 23,
			defense = 10,
			magic = 10,
			speed = 1
		}
	},
	pack = {}
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
	
func purchase_item(item):
	if(item.name in state.pack):
		equip_item(item)
	else:
		state.pack[item.name] = item
		print(state.pack)
	
func equip_item(item):
	state.player.equipment[item.location] = item.name
	
	print(state.player.stats)
	
	for stat in item.stats:
		state.player.stats[stat] += item.stats[stat]
		
	print(state.player.stats)
