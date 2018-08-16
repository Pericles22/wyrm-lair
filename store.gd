extends Node

var equipment = {
	iron_helm = {
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		location = 'head',
		cost = 150,
		img = 'iron_helm.png'
	},
	rusty_sword = {
		name = 'rusty_sword',
		stats = {
			attack = 3,
			speed = 1	
		},
		location = 'strong_hand',
		cost = 200,
		img = 'rusty_sword.png'
	},
	dirty_dagger = {
		name = 'dirty_dagger',
		stats = {
			attack = 2,
			speed = 2	
		},
		location = 'off_hand',
		cost = 200,
		img = 'dirty_dagger.png'
	}
}

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
		},
		gold = 500
	},
	pack = {}
}


func get_attack():
	var weapon = state.player.equipment.strong_hand
	var weapon_attack = 0 if not weapon else weapon.attack
	var attack_stat = get_stat('attack')
	
	return attack_stat + weapon_attack


func get_stat_level(name):
	var xp = state.player.stats[name]
	
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
	state.pack[item.name] = item
	update_gold(-item.cost)
	
func equip_item(item):
	state.player.equipment[item.location] = item.name
	
	print(state.player.stats)
	
	for stat in item.stats:
		state.player.stats[stat] += item.stats[stat]
	
	print(state.player.stats)
	
func update_gold(amount):
	state.player.gold += amount
	
func get_gold():
	return state.player.gold
