extends Control

var default_window_size = DisplayServer.window_get_size()
var queue_move_to_center: bool = false
var move_to_center_delay_time: float = 0.0

func _ready():
	var sfx_index = AudioServer.get_bus_index("Music")
	var start_value = AudioServer.get_bus_volume_db(sfx_index)
	%MusicSlider.value = db_to_linear(start_value)
	
	var sfx_index2 = AudioServer.get_bus_index("sfx")
	var start_value2 = AudioServer.get_bus_volume_db(sfx_index2)
	%SFXSlider.value = db_to_linear(start_value2)
	
	if get_window().mode == Window.MODE_FULLSCREEN:
		%FullscreenSwitch.button_pressed = true
	else:
		%FullscreenSwitch.button_pressed = false

func _on_button_pressed():
	var config = GlobalVariables.config
	config.set_value("Audio", "music", %MusicSlider.value)
	config.set_value("Audio", "sfx", %SFXSlider.value)
	config.set_value("Video", "fullscreen", %FullscreenSwitch.button_pressed)
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
		DisplayServer.window_set_size(default_window_size)
		queue_move_to_center = true

func _process(delta: float) -> void:
	if queue_move_to_center:
		move_to_center_delay_time += delta
		if move_to_center_delay_time > 0.1: # Slight delay is required to let the OS resize the window
			move_to_center_delay_time = 0.0
			queue_move_to_center = false
			get_viewport().move_to_center()
