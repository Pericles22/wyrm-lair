extends Node

var state = {
	skills = {
		accuracy = 1,
		alchemy = 1,
		defense = 1,
		health = 100,
		magicDamage = 1,
		maxHealth = 100,
		meleeDamage = 1,
		rangeDamage = 1,
		speed = 1
	}
}

func getStats():
	return {
		accuracy = 20 / state.skills.accuracy,
		health = state.skills.health,
		maxHealth = state.skills.maxHealth,
		meleeDamage = state.skills.meleeDamage * 20,
		rangeDamage = state.skills.rangeDamage * 10,
		speed = state.skills.speed + 120
	}
