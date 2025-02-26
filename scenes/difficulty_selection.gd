extends Node2D


func _on_normal_pressed():
	MusicManager.audioStreamPlayer.play()
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_hard_pressed():
	MusicManager.audioStreamPlayer.play()
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_impossible_pressed():
	MusicManager.audioStreamPlayer.play()
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_return_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
