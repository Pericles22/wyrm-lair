extends MarginContainer

var room = LairStore.lairFloor.room

func _ready():
	set_boundaries()
	check_monsters()
	pass

func set_boundaries():
	if(room < 5): $Vertical/Up/UpArrow.hide()
	else: $Vertical/Up/UpArrow.show()
	if(room > 12): $Vertical/Down/DownArrow.hide()
	else: $Vertical/Down/DownArrow.show()	
	if(room % 4 == 1): $Horizontal/Left/LeftArrow.hide()
	else: $Horizontal/Left/LeftArrow.show()
	if(room % 4 == 0): $Horizontal/Right/RightArrow.hide()
	else: $Horizontal/Right/RightArrow.show()


func check_monsters():
	if(LairStore.lairFloor.monsters[room-1] == 2): $NextFloor.show()
	elif(LairStore.lairFloor.monsters[room-1] % 2): RouteStore.replace('/fight')
	else: $NextFloor.hide()

func _on_UpArrow_pressed():
	PlayerStore.change_room(-4)

func _on_RightArrow_pressed():
	PlayerStore.change_room(1)

func _on_DownArrow_pressed():
	PlayerStore.change_room(4)
	
func _on_LeftArrow_pressed():
	PlayerStore.change_room(-1)
	
func _process(delta):
	if(room != LairStore.lairFloor.room):
		room = LairStore.lairFloor.room
		set_boundaries()
		check_monsters()



func _on_Map_pressed():
	RouteStore.assign('/city')

func _on_NextFloor_pressed():
	PlayerStore.next_floor()
	check_monsters()
	print(LairStore.lairFloor.level)