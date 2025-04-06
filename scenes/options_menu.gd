extends Node2D

func _ready():
	var sfx_index = AudioServer.get_bus_index("Music")
	var start_value = AudioServer.get_bus_volume_db(sfx_index)
	$CenterContainer/VBoxContainer/HSlider.value = start_value
	
	var sfx_index2 = AudioServer.get_bus_index("sfx")
	var start_value2 = AudioServer.get_bus_volume_db(sfx_index2)
	$CenterContainer/VBoxContainer/HSlider2.value = start_value2

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_h_slider_drag_ended(value_changed):
	if value_changed == true:
		var value = $CenterContainer/VBoxContainer/HSlider.value
		var sfx_index= AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(sfx_index, value)


func _on_h_slider_2_drag_ended(value_changed):
	if value_changed == true:
		var value = $CenterContainer/VBoxContainer/HSlider2.value
		var sfx_index= AudioServer.get_bus_index("sfx")
		AudioServer.set_bus_volume_db(sfx_index, value)
