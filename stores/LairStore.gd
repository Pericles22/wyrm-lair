extends Node

var lairFloor = {
	monsters = [],
	level = 1,
	room = 1,
	lastRoom = 1
}

var EnemyOrder = ['maggot', 'glowworm', 'earthworm', 'caterpillar', 'fireworm', 'centipede', 'earthworm', 'millipede', 'bobbit_worm']

var Enemies = {
	bobbit_worm = {
		moves = ['bite', 'burrow'],
		stats = {
			attack = 2 + lairFloor.level * 1.5,
			defense = 3 + lairFloor.level * 1.5,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	},
	caterpillar = {
		moves = ['bite', 'cocoon'],
		stats = {
			attack = 2 + lairFloor.level * 1.5,
			defense = 3 + lairFloor.level * 1.5,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	},
	centipede = {
		moves = ['poison', 'spit'],
		stats = {
			attack = 2 + lairFloor.level * 1.5,
			defense = 3 + lairFloor.level * 1.5,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	},
	earthworm = {
		moves = ['constrict', 'wriggle', 'burrow'],
		stats = {
			attack = 2 + lairFloor.level * 1.4,
			defense = 3 + lairFloor.level * 1.4,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	},
	fireworm = {
		moves = ['bite', 'wriggle'],
		stats = {
			attack = 2 + lairFloor.level * 1.5,
			defense = 3 + lairFloor.level * 1.5,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	},
	glowworm  = {
		moves = ['bite', 'soothe'],
		stats = {
			attack = 3 + lairFloor.level * 1.2,
			defense = 1 + lairFloor.level,
			speed = 0 + lairFloor.level,
			maxHealth = 20 + 2 * lairFloor.level,
      currHealth = 20 + 2 * lairFloor.level
		}
	},
	maggot = {
		moves = ['wriggle', 'burrow'],
		stats = {
			attack = 1 + lairFloor.level,
			defense = 1 + lairFloor.level,
			speed = 0 + lairFloor.level / 2,
			maxHealth = 10 + 2 * lairFloor.level,
      currHealth = 10 + 2 * lairFloor.level
		}
	},
	millipede = {
		moves = ['poison', 'curl'],
		stats = {
			attack = 2 + lairFloor.level * 1.5,
			defense = 3 + lairFloor.level * 1.5,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	},
	nightcrawler = {
		moves = ['constrict', 'burrow'],
		stats = {
			attack = 2 + lairFloor.level * 1.5,
			defense = 3 + lairFloor.level * 1.5,
			speed = 3 + lairFloor.level / 2,
			maxHealth = 20 + 3 * lairFloor.level,
      currHealth = 20 + 3 * lairFloor.level
		}
	}
}

func get_enemy(index):
	return Enemies[EnemyOrder[index]].duplicate()
