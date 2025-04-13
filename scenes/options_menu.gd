extends Node2D

func _ready():
	var sfx_index = AudioServer.get_bus_index("Music")
	var start_value = AudioServer.get_bus_volume_db(sfx_index)
	$CenterContainer/VBoxContainer/HSlider.value = db_to_linear(start_value)
	
	var sfx_index2 = AudioServer.get_bus_index("sfx")
	var start_value2 = AudioServer.get_bus_volume_db(sfx_index2)
	$CenterContainer/VBoxContainer/HSlider2.value = db_to_linear(start_value2)
	
	if get_window().mode == Window.MODE_FULLSCREEN:
		$CenterContainer/VBoxContainer/Label5/Fullscreen.button_pressed = true
	else:
		$CenterContainer/VBoxContainer/Label5/Fullscreen.button_pressed = false

func _on_button_pressed():
	var config = GlobalVariables.config
	config.set_value("Audio", "music", $CenterContainer/VBoxContainer/HSlider.value)
	config.set_value("Audio", "sfx", $CenterContainer/VBoxContainer/HSlider2.value)
	config.set_value("Video", "fullscreen", $CenterContainer/VBoxContainer/Label5/Fullscreen.button_pressed)
	config.save("user://options.cfg")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_slider_value_changed(value: float, bus: StringName) -> void:
	var bus_index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().mode = Window.MODE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED
