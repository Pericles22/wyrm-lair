extends Node

func calculate_damage_given(base_damage):
	return base_damage
	
func calculate_damage_taken(attacker, defender):
	if did_hit(attacker, defender):
		return floor(1 + (0.1 * attacker.damage) + max(0, attacker.damage - defender.defense) + (rand_range(-0.1, 0.1) * attacker.damage))
	else:
		return 0

func did_hit(attacker, defender):
	randomize()
	print(attacker)
	var chance = min(95, 10 + max(0, attacker.accuracy - defender.defense))
	var random_number = randi() % 100
	print(random_number, chance)
	return random_number <= chance
