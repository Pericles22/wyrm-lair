extends Node2D

const Particle = preload("res://scenes/items/DropParticles.tscn")
const Realm = preload("res://scenes/realm/Realm.tscn")
var loadNewRealm = true

func _ready():
	Functions.connect("change_realm", self, "clear_realm")
	Functions.connect("drop_item", self, "_on_Enemy_drop")
	Functions.connect("drop_item", self, "_on_Drop_pickup")
	Functions.connect("shoot", self, "_on_shoot")
	Functions.connect("spawn_enemy", self, "spawn_enemy")

func _process(delta: float):
	if loadNewRealm:
		load_new_realm()
		loadNewRealm = false

func clear_realm():
	print(get_children()[0].name)
	print(get_node("Realm"))
	if get_node("Realm"):
		get_node("Realm").queue_free()
		loadNewRealm = true
		
func _on_shoot(projectile, position, direction, dmg):
	get_node("Realm").add_child(projectile)
	projectile.start(position, direction, dmg)
	
func _on_Enemy_drop(drop, position, type):
	var d = drop.instance()
	get_node("Realm").add_child(d)
	d.start(position, type)
	
func _on_Drop_pickup(pos):
	var p = Particle.instance()
	get_node("Realm").add_child(p)
	p.position = pos

func load_new_realm():
	var r = Realm.instance()
	add_child(r)
	
func spawn_enemy(enemy, pos):
	print('where')
	get_node("Realm").add_child(enemy)
	enemy.position = pos