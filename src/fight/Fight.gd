extends MarginContainer

export(PackedScene) var MoveButton;

var enemy = {
	stats = {
		maxHealth = 200,
		currHealth = 200,
		defense = 10,
		attack = 10
	},
	moves = ['slash', 'harden', 'body_slam']
}
var player = PlayerStore.state.player

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
	
	unit.stats.currHealth = max(unit.stats.currHealth - amount, 0)
	
func body_slam(attacker, target):
	var amount = 55 - target.stats.defense
	target.stats.currHealth = max(target.stats.currHealth - amount, 0)
	
	attacker.stats.currHealth -= 10

func do_move(move):
	PlayerStore.do_move(move, player, enemy)
	
	$VBoxContainer/EnemyWrapper/EnemyContainer/ProgressBar.value = enemy.stats.currHealth
	$VBoxContainer/PlayerWrapper/PlayerContainer/ProgressBar.value = player.stats.currHealth
	
	if(!check_is_dead()):
		retaliate()
		
func retaliate():
	randomize()
	var index = randi()%enemy.moves.size()
	var move = enemy.moves[index]
	
	PlayerStore.do_move(move, enemy, player)
	
	$VBoxContainer/EnemyWrapper/EnemyContainer/ProgressBar.value = enemy.stats.currHealth
	$VBoxContainer/PlayerWrapper/PlayerContainer/ProgressBar.value = player.stats.currHealth
		
	check_is_dead()
		
func check_is_dead():
	if(player.stats.currHealth <= 0):
		end_fight(false)
		return true
	elif(enemy.stats.currHealth <= 0):
		end_fight(true)
		return true
	return false

func end_fight(victory):
	print('first:',LairStore.lairFloor.room)
	if(victory):
		print('we won')
		$FightHUD/OutcomeLabel.text = "VICTORY"
		$VBoxContainer/PlayerWrapper/PlayerContainer.hide()
		PlayerStore.kill_monster()
	else: 
		$FightHUD/OutcomeLabel.text = "DEFEAT"
		$VBoxContainer/EnemyWrapper/EnemyContainer.hide()
		print('what are we doing here', victory)
		PlayerStore.reset_room()
		
	print('second:',LairStore.lairFloor.room)
	
	$FightHUD/Buttons.hide()
	PlayerStore.change_scene('lair/LairRoom')
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
