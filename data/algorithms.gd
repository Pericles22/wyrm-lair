extends Node

func calculate_damage_given(base_damage):
	return base_damage
	
func calculate_damage_taken(attacker, defender):
	if did_hit(attacker, defender):
		return floor(1 + (0.1 * attacker.damage) + max(0, attacker.damage - defender.defense) + (rand_range(-0.1, 0.1) * attacker.damage))
	else:
		return 0
		
func calculate_target_pos(target, pos):
	var toTarget = target.global_position - pos

	var a = target.velocity.dot(target.velocity) - 40000;
	var b = 2 * target.velocity.dot(toTarget);
	var c = toTarget.dot(toTarget);
	
	var p = -b / (2 * a);
	var q = sqrt((b * b) - 4 * a * c) / (2 * a);
	
	var t1 = p - q;
	var t2 = p + q;
	var t;
	
	if t1 > t2 && t2 > 0:
	    t = t2;
	else:
	    t = t1;
	
	return target.position + target.velocity * t;

func did_hit(attacker, defender):
	randomize()
	var chance = min(95, 10 + max(0, attacker.accuracy - defender.defense))
	var random_number = randi() % 100
	return random_number <= chance
