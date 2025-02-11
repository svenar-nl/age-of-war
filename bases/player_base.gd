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
		get_node("/root/main_game/sprite_follow_player_mouse").queue_free()
		get_node("/root/main_game/Camera2D/in_game_menu").hide_turret_cancel_button_and_show_turret_menu()
		deactivate_buttons()
		var turret_base = load("res://bases/cave_turret_1.tscn").instantiate()
		self.add_child(turret_base)
		turret_base.position = $Button_tower_base.position + Vector2(16,16)
		turret_array[0] = 1
		turret_data[0] = turret_base
	elif turret_array[0] == 1: # means we are selling the turret
		deactivate_buttons()
		print(turret_data[0].name)
		turret_data[0].queue_free()
		turret_data[0] = null
		turret_array[0] = 0


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
	get_node("/root/main_game/sprite_follow_player_mouse").queue_free()
	get_node("/root/main_game/Camera2D/in_game_menu").hide_turret_cancel_button_and_show_turret_menu()
	deactivate_buttons()
	print("spawn turret")
	var turret_base = load("res://bases/cave_turret_1.tscn").instantiate()
	self.add_child(turret_base)
	turret_base.position = $Button_tower_bottom.position + Vector2(16,16)
	turret_array[1] = 1

func take_damage(damage):
	health -= damage
	if health <= 0:
		print("base destroyed")

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
