extends Control

signal filter

func _on_Button_pressed():
	Equipment.set_filtered_items(self.text.strip_edges())
