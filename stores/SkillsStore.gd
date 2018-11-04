extends Node

var Moves = {
	bite = {
		target = {
			currHealth = -1
		}
	},
	body_slam = {
		agent = {
			currHealth = -1
		},
		target = {
			currHealth = -3
		}
	},
	burrow = {
		agent = {
			defense = 2
		}
	},
	cocoon = {
		agent = {
			defense = 2,
			speed = -1
		}
	},
	constrict = {
		target = {
			currHealth = -1,
			speed = -2
		}
	},
	curl = {
		agent = {
			defense = 1
		}
	},
	harden = {
		agent = {
			defense = 2
		}
	},
	poison = {
		target = {
			currHealth = -1,
			speed = -1
		}
	},
	slash = {
		target = {
			currHealth = -2
		}
	},
	soothe = {
		agent = {
			currHealth = 1
		}
	},
	spit = {
		target = {
			defense = -1
		}
	},
	wriggle = {
		target = {
			attack = -1
		}
	}
}

func calculate_damage(agent, target, stat):
	return min(stat - agent.stats.attack + target.stats.defense, 0)

func do_move(move, agent, target):
	if('agent' in Moves[move]):
		var agentStats = Moves[move].agent
		for stat in agentStats:
			update_unit_stats(agent, stat, agentStats[stat])
	
	if('target' in Moves[move]):
		var targetStats = Moves[move].target
		for stat in targetStats:
			if(stat == 'currHealth'): update_unit_stats(target, stat, calculate_damage(agent, target, targetStats[stat]))
			else: update_unit_stats(target, stat, targetStats[stat])

func update_unit_stats(unit, statName, stat):
	unit.stats[statName] = max(0, unit.stats[statName] + stat)

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
