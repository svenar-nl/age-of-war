extends Node2D

func _ready() -> void:
	if not GlobalVariables.config:
		GlobalVariables.config = ConfigFile.new()
		var config = GlobalVariables.config
		config.load("user://options.cfg")

		var value = config.get_value("Audio", "music", 0)
		var bus_index = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

		value = config.get_value("Audio", "sfx", 0)
		bus_index = AudioServer.get_bus_index("sfx")
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

		value = config.get_value("Video", "fullscreen", false)
		if value:
			get_window().mode = Window.MODE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED


func _on_play_pressed():
	GlobalVariables.current_stage = GlobalVariables.stage.cave
	GlobalVariables.player_exp = 0
	GlobalVariables.player_money = 175
	get_tree().change_scene_to_file("res://scenes/difficulty_selection.tscn")

func _on_instructions_pressed():
	get_tree().change_scene_to_file("res://scenes/instructions_screen.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_extra_pressed():
	get_tree().change_scene_to_file("res://scenes/extra_screen.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
