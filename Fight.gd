extends MarginContainer

export(PackedScene) var MoveButton;

var enemy = {
	maxHealth = 200,
	currHealth = 200,
	stats = {
		defense = 10
	},
	moves = ['slash']
}
var player = store.state.player

func _ready():
	for move in player.moves:
		var button = MoveButton.instance()
		button.text = move
		button.connect('do_move', self, 'do_move', [move])
		
		$FightHUD/Buttons.add_child(button)
	
func harden(unit):
	unit.stats.defense += 2

func slash(unit):
	var amount = 20 - unit.stats.defense
	
	unit.currHealth -= max(amount, 0)

func do_move(move):
	match move:
		'slash': 
			slash(enemy)
			$VBoxContainer/EnemyWrapper/EnemyContainer/ProgressBar.value = enemy.currHealth
		'harden': harden(player)
		
	if(!check_is_dead()):
		retaliate('slash')
		
func retaliate(move):
	match move:
		'slash': 
			slash(player)
			$VBoxContainer/PlayerWrapper/PlayerContainer/ProgressBar.value = player.currHealth
		
	check_is_dead()
		
func check_is_dead():
	if(player.currHealth <= 0):
		$FightHUD/OutcomeLabel.text = "DEFEAT"
		$VBoxContainer/PlayerWrapper/PlayerContainer.hide()
		$FightHUD/Buttons.hide()
		get_tree().change_scene('res://Main.tscn')
		return true
	elif(enemy.currHealth <= 0):
		$FightHUD/OutcomeLabel.text = "VICTORY"
		$VBoxContainer/EnemyWrapper/EnemyContainer.hide()
		$FightHUD/Buttons.hide()
		get_tree().change_scene('res://Main.tscn')
		return true
	else:
		return false	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
