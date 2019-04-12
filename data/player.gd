extends Node

signal updateLevel

var requiredXP = pow(log(2), 2)

var state = {
	inventory = [
		"wood body",
		"wood helm",
		"wood shield",
		"wood sword"
	],
	skills = {
		accuracy = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		defense = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		health = {
			experience = 0,
			level = 100,
			requiredXP = requiredXP
		},
		magicDamage = {
			experience = 0,
			level = 10,
			requiredXP = requiredXP
		},
		maxHealth = {
			experience = 0,
			level = 100,
			requiredXP = requiredXP
		},
		meleeDamage = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		rangeDamage = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		speed = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		}
	}
}

func getLevels():
	return {
		accuracy = state.skills.accuracy.level,
		health = state.skills.health.level,
		maxHealth = state.skills.maxHealth.level,
		meleeDamage = state.skills.meleeDamage.level,
		rangeDamage = state.skills.rangeDamage.level,
		speed = state.skills.speed.level,
	}

func getStats():
	return {
		accuracy = 20 * state.skills.accuracy.level,
		health = state.skills.health.level + 99,
		maxHealth = state.skills.maxHealth.level + 99,
		meleeDamage = state.skills.meleeDamage.level * 10,
		rangeDamage = state.skills.rangeDamage.level * 5,
		speed = state.skills.speed.level + 120
	}
	
func updateStat(stat, xp):
	var playerStat = state.skills[stat]
	playerStat.experience += xp
	if playerStat.experience >= playerStat.requiredXP:
		print(playerStat.experience, playerStat.requiredXP)
		playerStat.level += 1
		playerStat.requiredXP += pow(log(playerStat.level + 1), 2) * pow(playerStat.level + 1, 2)
		updateStat(stat, 0)
	emit_signal('updateLevel', state.skills.rangeDamage.level, stat)
	print(getStats())
