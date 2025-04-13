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


func _on_slider_value_changed(value: float, bus: StringName) -> void:
	var bus_index = AudioServer.get_bus_index(bus)
	if value == -50:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, value)


