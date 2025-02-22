extends StaticBody2D

@export var is_player_owned: bool = true

var health
var turret_array : Array
var turret_data : Array

var current_state = 9999
enum state {idle, attack, walk, die}

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 500
	
	# -1 unavailable to build (because no space)
	# 0 means no turret (but there is space to build)
	# 1 means there is a turret
	# first element is for base
	# second is for bottom
	# third is for part
	# fourth is for top
	turret_array = [0,-1,-1,-1]
	turret_data = [null, null, null, null]
	$tower_bottom.hide()
	$tower_part.hide()
	$tower_top.hide()
	
	
	
	deactivate_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(health)


func add_turret_spot():
	if turret_array[1] == -1:
		$tower_bottom.show()
		turret_array[1] = 0
	elif turret_array[2] == -1:
		$tower_part.show()
		turret_array[2] = 0
	elif turret_array[3] == -1:
		$tower_top.show()
		turret_array[3] = 0


func _on_button_tower_base_pressed():
	if turret_array[0] == 0: # means we are buying the turret
		var turret_name = get_node("/root/main_game/sprite_follow_player_mouse").turret_name
		get_node("/root/main_game/sprite_follow_player_mouse").queue_free()
		get_node("/root/main_game/Camera2D/in_game_menu").hide_turret_cancel_button_and_show_turret_menu()
		deactivate_buttons()
		# print(turret_name)
		var turret_base = load("res://bases/" + turret_name + ".tscn").instantiate()
		turret_base.name += "_" + str(randi())
		self.add_child(turret_base)
		turret_base.position = $Button_tower_base.position + Vector2(16,16)
		turret_array[0] = 1
		turret_data[0] = turret_base
	elif turret_array[0] == 1: # means we are selling the turret
		deactivate_buttons()
		var stage = turret_data[0].name.split("_")[0]
		var turret_number = int(turret_data[0].name.split("_")[2])
		var refund = GlobalVariables.get_turret_price(GlobalVariables.get_stage_from_string(stage), turret_number) / 2
		GlobalVariables.player_money += refund
		turret_data[0].queue_free()
		turret_data[0] = null
		turret_array[0] = 0
		get_node("/root/main_game/Camera2D/in_game_menu")._on_cancel_sell_turret_pressed()


func activate_turret_buy_buttons():
	if turret_array[0] == 0:
		$Button_tower_base.disabled = false
	
	if turret_array[1] == 0:
		$Button_tower_bottom.disabled = false
	
	if turret_array[2] == 0:
		$Button_tower_part.disabled = false
	
	if turret_array[3] == 0:
		$Button_tower_top.disabled = false

func activate_turret_sell_buttons():
	# same buttons lol
	if turret_array[0] == 1:
		$Button_tower_base.disabled = false
	
	if turret_array[1] == 1:
		$Button_tower_bottom.disabled = false
	
	if turret_array[2] == 1:
		$Button_tower_part.disabled = false
	
	if turret_array[3] == 1:
		$Button_tower_top.disabled = false

func activate_buttons():
	$Button_tower_base.disabled = false
	$Button_tower_bottom.disabled = false
	$Button_tower_part.disabled = false
	$Button_tower_top.disabled = false

func deactivate_buttons():
	$Button_tower_base.disabled = true
	$Button_tower_bottom.disabled = true
	$Button_tower_part.disabled = true
	$Button_tower_top.disabled = true

func hide_buttons():
	$Button_tower_base.hide()
	$Button_tower_bottom.hide()
	$Button_tower_part.hide()
	$Button_tower_top.hide()


func _on_button_tower_bottom_pressed():
	if turret_array[1] == 0: # means we are buying the turret
		var turret_name = get_node("/root/main_game/sprite_follow_player_mouse").turret_name
		get_node("/root/main_game/sprite_follow_player_mouse").queue_free()
		get_node("/root/main_game/Camera2D/in_game_menu").hide_turret_cancel_button_and_show_turret_menu()
		deactivate_buttons()
		var turret_base = load("res://bases/" + turret_name + ".tscn").instantiate()
		turret_base.name += "_" + str(randi())
		self.add_child(turret_base)
		turret_base.position = $Button_tower_bottom.position + Vector2(16,16)
		turret_array[1] = 1
		turret_data[1] = turret_base
	elif turret_array[1] == 1: # means we are selling the turret
		deactivate_buttons()
		var stage = turret_data[1].name.split("_")[0]
		var turret_number = int(turret_data[1].name.split("_")[2])
		var refund = GlobalVariables.get_turret_price(GlobalVariables.get_stage_from_string(stage), turret_number) / 2
		GlobalVariables.player_money += refund
		turret_data[1].queue_free()
		turret_data[1] = null
		turret_array[1] = 0
		get_node("/root/main_game/Camera2D/in_game_menu")._on_cancel_sell_turret_pressed()

func take_damage(damage):
	health -= damage
	if health <= 0:
		print("base destroyed")
		if is_player_owned == true:
			print("emit signal base destroyed for player base and change to game over screen")
		elif is_player_owned == false:
			print("emit signal base destroyed for enemy base and change to win screen")

func get_number_of_turret_slots():
	var number = 0
	for i in turret_array:
		if i == 0 or i == 1:
			number += 1
	return number

func get_price_of_new_turret_slot():
	var number = get_number_of_turret_slots()
	if number == 1:
		return 1000
	elif number == 2:
		return 3000
	elif number == 3:
		return 7500
	elif number == 4:
		return INF


func _on_button_tower_part_pressed():
	if turret_array[2] == 0: # means we are buying the turret
		var turret_name = get_node("/root/main_game/sprite_follow_player_mouse").turret_name
		get_node("/root/main_game/sprite_follow_player_mouse").queue_free()
		get_node("/root/main_game/Camera2D/in_game_menu").hide_turret_cancel_button_and_show_turret_menu()
		deactivate_buttons()
		var turret_base = load("res://bases/" + turret_name + ".tscn").instantiate()
		turret_base.name += "_" + str(randi())
		self.add_child(turret_base)
		turret_base.position = $Button_tower_part.position + Vector2(16,16)
		turret_array[2] = 1
		turret_data[2] = turret_base
	elif turret_array[2] == 1: # means we are selling the turret
		deactivate_buttons()
		var stage = turret_data[1].name.split("_")[0]
		var turret_number = int(turret_data[1].name.split("_")[2])
		var refund = GlobalVariables.get_turret_price(GlobalVariables.get_stage_from_string(stage), turret_number) / 2
		GlobalVariables.player_money += refund
		turret_data[2].queue_free()
		turret_data[2] = null
		turret_array[2] = 0
		get_node("/root/main_game/Camera2D/in_game_menu")._on_cancel_sell_turret_pressed()


func _on_button_tower_top_pressed():
	if turret_array[3] == 0: # means we are buying the turret
		var turret_name = get_node("/root/main_game/sprite_follow_player_mouse").turret_name
		get_node("/root/main_game/sprite_follow_player_mouse").queue_free()
		get_node("/root/main_game/Camera2D/in_game_menu").hide_turret_cancel_button_and_show_turret_menu()
		deactivate_buttons()
		var turret_base = load("res://bases/" + turret_name + ".tscn").instantiate()
		turret_base.name += "_" + str(randi())
		self.add_child(turret_base)
		turret_base.position = $Button_tower_top.position + Vector2(16,16)
		turret_array[3] = 1
		turret_data[3] = turret_base
	elif turret_array[3] == 1: # means we are selling the turret
		deactivate_buttons()
		var stage = turret_data[1].name.split("_")[0]
		var turret_number = int(turret_data[1].name.split("_")[2])
		var refund = GlobalVariables.get_turret_price(GlobalVariables.get_stage_from_string(stage), turret_number) / 2
		GlobalVariables.player_money += refund
		turret_data[3].queue_free()
		turret_data[3] = null
		turret_array[3] = 0
		get_node("/root/main_game/Camera2D/in_game_menu")._on_cancel_sell_turret_pressed()

func advance_base_sprite():
	if GlobalVariables.current_stage == GlobalVariables.stage.knight:
		$Sprite2D.texture = load("res://age of war sprites/bases/knight/base/base.png")
		$tower_bottom.texture = load("res://age of war sprites/bases/knight/tower_base/base_tower_bottom.png")
		$tower_part.texture = load("res://age of war sprites/bases/knight/tower_part/base_tower_part.png")
		$tower_top.texture = load("res://age of war sprites/bases/knight/tower_top/base_tower_top.png")
		health = int(health * 750 / 500)
	elif GlobalVariables.current_stage == GlobalVariables.stage.medival:
		$Sprite2D.texture = load("res://age of war sprites/bases/medival/base/base.png")
		$tower_bottom.texture = load("res://age of war sprites/bases/medival/tower_base/base_tower_bottom.png")
		$tower_part.texture = load("res://age of war sprites/bases/medival/tower_part/base_tower_part.png")
		$tower_top.texture = load("res://age of war sprites/bases/medival/tower_top/base_tower_top.png")
		health = int(health * 1000 / 750)
	elif GlobalVariables.current_stage == GlobalVariables.stage.miltary:
		$Sprite2D.texture = load("res://age of war sprites/bases/miltary/base/base.png")
		$tower_bottom.texture = load("res://age of war sprites/bases/miltary/tower_base/base_tower_bottom.png")
		$tower_part.texture = load("res://age of war sprites/bases/miltary/tower_part/base_tower_part.png")
		$tower_top.texture = load("res://age of war sprites/bases/miltary/tower_top/base_tower_top.png")
		health = int(health * 1500 / 1000)
	elif GlobalVariables.current_stage == GlobalVariables.stage.future:
		$Sprite2D.texture = load("res://age of war sprites/bases/future/base/base.png")
		$tower_bottom.texture = load("res://age of war sprites/bases/future/tower_base/base_tower_bottom.png")
		$tower_part.texture = load("res://age of war sprites/bases/future/tower_part/base_tower_part.png")
		$tower_top.texture = load("res://age of war sprites/bases/future/tower_top/base_tower_top.png")
		health = int(health * 3000 / 1500)
