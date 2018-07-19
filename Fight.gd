extends MarginContainer

export(PackedScene) var MoveButton;

var enemy = {
	type = 'enemy',
	maxHealth = 200,
	currHealth = 200,
	defense = 5,
	moves = ['slash']
}
var player = {
	type = 'player',
	maxHealth = 200,
	currHealth = 200,
	defense = 5,
	moves = ['slash','harden']
}

func _ready():
	for move in player.moves:
		var button = MoveButton.instance()
		button.text = move
		button.connect('do_move', self, 'do_move', [move])
		
		$FightHUD/Buttons.add_child(button)
	
func harden(unit):
	unit.defense += 2

func slash(unit):
	var amount = 20 - unit.defense
	
	unit.currHealth -= max(amount, 0)

func do_move(move):
	match move:
		'slash': 
			slash(enemy)
			$VBoxContainer/EnemyContainer/ProgressBar.value = enemy.currHealth
		'harden': harden(player)
		
	if(!check_is_dead()):
		retaliate('slash')
		
func retaliate(move):
	match move:
		'slash': 
			slash(player)
			$VBoxContainer/PlayerContainer/ProgressBar.value = player.currHealth
		
	check_is_dead()
		
func check_is_dead():
	if(player.currHealth <= 0):
		print('player died')
		return true
	elif(enemy.currHealth <= 0):
		print('enemy died')
		$VBoxContainer/EnemyContainer.hide()
		return true
	else:
		return false	


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
