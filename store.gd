extends Node

var moves = {
	body_slam = {
		agent = {
			currHealth = -10
		},
		target = {
			currHealth = -55
		}
	},
	slash = {
		target = {
			currHealth = -20
		}
	},
	harden = {
		agent = {
			defense = 2
		}
	}
}

var equipment = {
	iron_helm = {
		name = 'iron_helm',
		stats = {
			defense = 2,
			speed = -1	
		},
		location = 'head',
		cost = 15,
		img = 'iron_helm.png'
	},
	rusty_sword = {
		name = 'rusty_sword',
		stats = {
			attack = 3,
			speed = 1	
		},
		location = 'strong_hand',
		cost = 20,
		img = 'rusty_sword.png'
	},
	dirty_dagger = {
		name = 'dirty_dagger',
		stats = {
			attack = 2,
			speed = 2	
		},
		location = 'off_hand',
		cost = 20,
		img = 'dirty_dagger.png'
	},
	leather_shoe = {
		name = 'leather_shoe',
		stats = {
			speed = 3,
			defense = 1
		},
		location = 'feet',
		cost = 14,
		img = 'leather_shoe.png'
	},
	iron_greaves = {
		name = 'iron_greaves',
		stats = {
			speed = -1,
			defense = 2
		},
		location = 'legs',
		cost = 14,
		img = 'iron_greaves.png'
	},
	iron_breastplate = {
		name = 'iron_breastplate',
		stats = {
			speed = -1,
			defense = 4
		},
		location = 'torso',
		cost = 24,
		img = 'iron_breastplate.png'
	}
}

var state = {
	player = {
		moves = ['slash','harden', 'body_slam'],
		equipment = {
			head = null,
			torso = null,
			legs = null,
			feet = null,
			off_hand = null,
			strong_hand = null
		},
		stats = {
			currHealth = 200,
			maxHealth = 200,
			attack = 23,
			defense = 10,
			magic = 10,
			speed = 1
		},
		gold = 500
	},
	pack = {}
}


func calculate_damage(agent, target, stat):
	return min(stat - agent.stats.attack + target.stats.defense, 0) # TODO: Defense/attack stats should not apply to self-inflicted damage, like body_slam

func do_move(move, agent, target):
	if('agent' in moves[move]):
		var agentStats = moves[move].agent
		for stat in agentStats:
			if(stat == 'currHealth'): update_unit_stats(agent, stat, calculate_damage(agent, target, agentStats[stat]))
			else: update_unit_stats(agent, stat, agentStats[stat])
	
	if('target' in moves[move]):
		var targetStats = moves[move].target
		for stat in targetStats:
			if(stat == 'currHealth'): update_unit_stats(target, stat, calculate_damage(agent, target, targetStats[stat]))
			else: update_unit_stats(target, stat, targetStats[stat])

func equip_item(item):
	var currentItemName = location_already_equipped(item.location)
	
	if(currentItemName):
		var currentItem = equipment[currentItemName]
		update_stats(currentItem, 'unequip')
		unequip_item(item.location)
	
	state.player.equipment[item.location] = item.name
	
	update_stats(item, 'equip')

func get_attack():
	var weapon = state.player.equipment.strong_hand
	var weapon_attack = 0 if not weapon else weapon.attack
	var attack_stat = get_stat('attack')
	
	return attack_stat + weapon_attack

func get_gold():
	return state.player.gold

func get_item(itemName):
	return equipment[itemName]

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

func location_already_equipped(location):
	return state.player.equipment[location]

func purchase_item(item):
	state.pack[item.name] = item
	update_gold(-item.cost)

func unequip_item(location):
	state.player.equipment[location] = null

func update_gold(amount):
	state.player.gold += amount

func update_stats(item, action):
	print(state.player.stats)
	
	match action:
		'equip':
			for stat in item.stats:
				state.player.stats[stat] += item.stats[stat]
		'unequip':
			for stat in item.stats:
				state.player.stats[stat] -= item.stats[stat]
				

func update_unit_stats(unit, statName, stat):
	print('unit:', unit)
	print('statName:', statName)
	print('stat:', stat)
	
	unit.stats[statName] = max(0, unit.stats[statName] + stat)
