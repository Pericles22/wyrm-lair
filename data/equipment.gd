extends Node

signal filter_updated

var categories = ["all", "armor", "experience", "other", "potions", "weapons"]

var equipment = {
	"wood body": {
		category = "armor",
		image = "wood/wood-body.png",
		label = "wood body"
	},
	"wood helm": {
		category = "armor",
		image = "wood/wood-helm.png",
		label = "wood helm"
	},
	"wood shield": {
		category = "armor",
		image = "wood/wood-shield.png",
		label = "wood shield"
	},
	"wood sword": {
		category = "weapons",
		image = "wood/wood-sword.png",
		label = "wood sword"
	}
}

var filtered_items = {}

func _ready():
	set_filtered_items('all')

func set_filtered_items(cat):
	filtered_items = {}
	if cat == 'all':
		filtered_items = equipment
	else:
		for key in equipment:
			var piece = equipment[key]
			if piece.category == cat:
				filtered_items[key] = piece

	emit_signal("filter_updated", filtered_items)