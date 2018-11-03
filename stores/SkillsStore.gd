extends Node

var Moves = {
	bite = {
		defender = {
			health = -1
		}
	},
	burrow = {
		attacker = {
			defense = 2
		}
	},
	cocoon = {
		attacker = {
			defense = 2,
			speed = -1
		}
	},
	constrict = {
		defender = {
			health = -1,
			speed = -2
		}
	},
	curl = {
		attacker = {
			defense = 1
		}
	},
	poison = {
		defender = {
			health = -1,
			speed = -1
		}
	},
	soothe = {
		attacker = {
			health = 1
		}
	},
	spit = {
		defender = {
			defense = -1
		}
	},
	wriggle = {
		defender = {
			offense = -1
		}
	}
}

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
