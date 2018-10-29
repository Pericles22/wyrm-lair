extends Node

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

func _ready():
	pass
