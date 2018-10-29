extends MarginContainer

var room = Lair.lairFloor.room

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
	if(Lair.lairFloor.monsters[room-1] == 2): $NextFloor.show()
	elif(Lair.lairFloor.monsters[room-1]): store.change_scene('Fight')
	else: $NextFloor.hide()

func _on_UpArrow_pressed():
	store.change_room(-4)

func _on_RightArrow_pressed():
	store.change_room(1)

func _on_DownArrow_pressed():
	store.change_room(4)
	
func _on_LeftArrow_pressed():
	store.change_room(-1)
	
func _process(delta):
	if(room != Lair.lairFloor.room):
		room = Lair.lairFloor.room
		set_boundaries()
		check_monsters()



func _on_Map_pressed():
	store.change_scene('Main')

func _on_NextFloor_pressed():
	store.next_floor()
	check_monsters()
	print(Lair.lairFloor.level)