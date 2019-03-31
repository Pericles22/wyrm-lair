extends Node

var state = {
    "speed boost": {
        description = 'Speed boost: This item grants twenty speed when picked up.',
        image = "drop1.png",
        isPermanent = true,
		stats = {
        	speed = 20,
		}
    },
    "health potion": {
        description = 'Health Potion: Grants 10 health when picked up',
        image = "drop2.png",
        isPermanent = true,
		stats = {
			health = 10
		}
    },
    "damage potion": {
        description = 'Damage Potion: Adds 10 melee damage when picked up.',
        image = "drop3.png",
        isPermanent = true,
		stats = {
			damage = 10
		}
    },
    "range potion": {
        description = 'Range Potion: Adds 5 range damage when picked up.',
        image = "drop4.png",
        isPermanent = true,
		stats = {
			rangeDamage = 5	
		}
    }
}