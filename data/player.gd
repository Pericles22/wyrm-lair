extends Node

var requiredXP = pow(log(2), 2)

var state = {
	skills = {
		accuracy = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		health = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		magicDamage = {
			experience = 0,
			level = 1,
			requiredXP = requiredXP
		},
		maxHealth = {
			experience = 0,
			level = 1,
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

#requiredXP += pow(log(playerLevel + 1),2) * pow(playerLevel + 1,2)

func getStats():
	return {
		accuracy = 20 / state.skills.accuracy.level,
		health = state.skills.health.level + 99,
		maxHealth = state.skills.maxHealth.level + 99,
		meleeDamage = state.skills.meleeDamage.level * 20,
		rangeDamage = state.skills.rangeDamage.level * 5,
		speed = state.skills.speed.level + 120
	}
	
func updateStat(stat, xp):
	print(stat + ', ', xp)
	var playerStat = state.skills[stat]
	print('playerStat, ', playerStat)
	playerStat.experience += xp
	if playerStat.experience >= playerStat.requiredXP:
		playerStat.level += 1
		playerStat.requiredXP += pow(log(playerStat.level + 1), 2) * pow(playerStat.level + 1, 2)
		print(playerStat, ', ', playerStat.requiredXP)
