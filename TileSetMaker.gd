extends Node

var tile_size = Vector2(16, 16)
onready var texture = $Sprite.texture
var num = 1

func _ready():
	var tex_width = texture.get_width() / tile_size.x
	var tex_height = texture.get_height() / tile_size.y
	print(tex_width, tex_height)
	var ts = TileSet.new()
	for x in range(tex_width):
		for y in range(tex_height):
			print(num)
			num += 1
			var region = Rect2(x * tile_size.x, y * tile_size.y, tile_size.x, tile_size.y)
			
			var id = x + y * 10
			ts.create_tile(id)
			ts.tile_set_texture(id, texture)
			ts.tile_set_region(id, region)
			
	ResourceSaver.save("res://bg_tiles.tres", ts)