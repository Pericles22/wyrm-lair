extends 'res://nodes/Router.gd'

export(PackedScene) var MoveButton;

func get_enemy():
	randomize()
	var currentFloor = LairStore.lairFloor.level
	var index = max(floor(randi() % 5) + floor(currentFloor/2) - 5, 0)
	return LairStore.get_enemy(index)
	
var enemy = get_enemy()

var player = PlayerStore.state.player

func _ready():
	print(enemy.stats)
	for move in player.moves:
		var button = MoveButton.instance()
		button.text = move
		button.connect('do_move', self, 'do_move', [move])
		
		$FightHUD/Buttons.add_child(button)

func do_move(move):
	SkillsStore.do_move(move, player, enemy)
	
	print(enemy.stats)
	
	if(!check_is_dead()):
		retaliate()
		
func retaliate():
	randomize()
	var index = randi()%enemy.moves.size()
	var move = enemy.moves[index]
	
	SkillsStore.do_move(move, enemy, player)
		
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
		$FightHUD/OutcomeLabel.text = "VICTORY"
		$VBoxContainer/PlayerWrapper/PlayerContainer.hide()
		PlayerStore.kill_monster()
	else: 
		$FightHUD/OutcomeLabel.text = "DEFEAT"
		$VBoxContainer/EnemyWrapper/EnemyContainer.hide()
		PlayerStore.reset_room()
		
	$FightHUD/Buttons.hide()
	RouteStore.replace('/lair')
	
func get_health(unit):
	return unit.stats.currHealth * 100 / unit.stats.maxHealth

func _process(delta):
	$VBoxContainer/EnemyWrapper/EnemyContainer/ProgressBar.value = get_health(enemy)
	$VBoxContainer/PlayerWrapper/PlayerContainer/ProgressBar.value = get_health(player)
