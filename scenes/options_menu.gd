extends Node2D





func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_h_slider_drag_ended(value_changed):
	var sfx_index= AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(sfx_index, value_changed)


func _on_h_slider_2_drag_ended(value_changed):
	var sfx_index= AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_volume_db(sfx_index, value_changed)
