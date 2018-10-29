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
		quantity = 1,
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
		quantity = 1,
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
		quantity = 1,
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
		quantity = 1,
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
		quantity = 1,
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
		quantity = 1,
		img = 'iron_breastplate.png'
	},
	small_potion = {
		name = 'small_potion',
		stats = {
			currHealth = 10	
		},
		cost = 20,
		location = null,
		quantity = 3,
		img = 'small_potion.png'
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
			currHealth = 200, #Apparently the potions are being doubly effective, maybe all stat changes are doing that?
			maxHealth = 200,
			attack = 23,
			defense = 40,
			magic = 10,
			speed = 1
		},
		gold = 500
	},
	pack = {}
}


func _ready():
	generate_floor()

func calculate_damage(agent, target, stat):
	return min(stat - agent.stats.attack + target.stats.defense, 0)
	
func change_room(amt):
	LairStore.lairFloor.room += amt

func change_scene(scene):
	get_tree().change_scene('res://src/' + scene + '.tscn')

func do_move(move, agent, target):
	if('agent' in moves[move]):
		var agentStats = moves[move].agent
		for stat in agentStats:
			update_unit_stats(agent, stat, agentStats[stat])
	
	if('target' in moves[move]):
		var targetStats = moves[move].target
		for stat in targetStats:
			if(stat == 'currHealth'): update_unit_stats(target, stat, calculate_damage(agent, target, targetStats[stat]))
			else: update_unit_stats(target, stat, targetStats[stat])

func equip_item(item):
	if(item.location): 
		var currentItemName = location_already_equipped(item.location)
	
		if(currentItemName):
			var currentItem = equipment[currentItemName]
			update_stats(currentItem, 'unequip')
			unequip_item(item.location)
		
		state.player.equipment[item.location] = item.name
	
	state.pack.erase(item.name)
	
	update_stats(item, 'equip')

func generate_floor():
	var roomArr = []
	
	randomize()
	for i in range(16):
		var num = 0
		if(randi()%3 == 0): 
			num = 1
		roomArr.push_back(num)
	
	roomArr[randi()%16] = 2
	
	print(roomArr)
		
	set_floor(roomArr)

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
	
func kill_monster():
	LairStore.lairFloor.monsters[LairStore.lairFloor.room - 1] = 0

func location_already_equipped(location):
	return state.player.equipment[location]

func next_floor():
	LairStore.lairFloor.level += 1
	generate_floor()

func purchase_item(item):
	if(item.name in state.pack):
		var packItem = state.pack[item.name]
		var newCount = packItem.quantity + item.quantity
		packItem.quantity = newCount
		print(newCount, packItem.quantity)
	else:
		state.pack[item.name] = item.duplicate()
	update_gold(-item.cost)

func reset_room():
	LairStore.lairFloor.room = LairStore.lairFloor.lastRoom

func set_floor(floorArr):
	LairStore.lairFloor.monsters = floorArr

func unequip_item(location):
	state.player.equipment[location] = null

func update_gold(amount):
	state.player.gold += amount

func update_stats(item, action):
	match action:
		'equip':
			for stat in item.stats:
				if(stat == 'currHealth'): 
					state.player.stats[stat] = min(state.player.stats[stat] + item.stats[stat], state.player.stats.maxHealth)
				state.player.stats[stat] += item.stats[stat]
		'unequip':
			for stat in item.stats:
				state.player.stats[stat] -= item.stats[stat]
				

func update_unit_stats(unit, statName, stat):
	unit.stats[statName] = max(0, unit.stats[statName] + stat)
