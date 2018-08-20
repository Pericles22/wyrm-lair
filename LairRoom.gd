extends MarginContainer

var roomArr = []

func _ready():
	generate_matrix()

func generate_matrix():
	randomize()
	for i in range(16):
		var num = 0
		if(randi()%3 == 0): 
			num = 1
		roomArr.push_back(num)
		
	store.set_floor(roomArr)

#func _process(delta):
	#pass
	
