extends Node2D


var unit_array : Array
var player_unit_spawn_position : Vector2 = Vector2(240,570)
var player_spawn_location_occupied : bool = false
var unable_to_spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.global_position = Vector2(576, 280)
	$Camera2D/in_game_menu.connect("spawn_melee", _on_melee_button_pressed)
	$Camera2D/in_game_menu.connect("spawn_range", _on_range_button_pressed)
	$Camera2D/in_game_menu.connect("spawn_tank", _on_tank_button_pressed)
	unable_to_spawn = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Camera2D/in_game_menu/money.text = "money: " + str(GlobalVariables.player_money)
	$Camera2D/in_game_menu/exp.text = "exp: " + str(GlobalVariables.player_exp)


func get_first_player_unit():
	pass
	
func get_first_enemy_unit():
	pass

func get_last_player_unit():
	pass
	
func get_last_enemy_unit():
	pass

func _on_melee_button_pressed():
	if unable_to_spawn == true:
		return
	var new_melee_unit = load("res://units/" + GlobalVariables.get_current_age_as_string() + "/melee/" + GlobalVariables.get_current_age_as_string() + "_melee.tscn").instantiate()
	new_melee_unit.position = player_unit_spawn_position
	new_melee_unit.is_player_owned = true
	add_child(new_melee_unit)
	
	var cave_melee2 = load("res://units/" + GlobalVariables.get_current_age_as_string() + "/melee/" + GlobalVariables.get_current_age_as_string() + "_melee.tscn").instantiate()
	cave_melee2.position = Vector2(1400,570)
	cave_melee2.is_player_owned = false
	add_child(cave_melee2)
	


func _on_range_button_pressed():
	if unable_to_spawn == true:
		return
	var cave_range = load("res://units/" + GlobalVariables.get_current_age_as_string() + "/range/" + GlobalVariables.get_current_age_as_string() + "_range.tscn").instantiate()
	cave_range.position = player_unit_spawn_position
	cave_range.is_player_owned = true
	add_child(cave_range)
	
	var cave_range2 = load("res://units/" + GlobalVariables.get_current_age_as_string() + "/range/" + GlobalVariables.get_current_age_as_string() + "_range.tscn").instantiate()
	cave_range2.position = Vector2(1400,570)
	cave_range2.is_player_owned = false
	add_child(cave_range2)
	


func _on_tank_button_pressed():
	if unable_to_spawn == true:
		return
	var cave_tank = load("res://units/" + GlobalVariables.get_current_age_as_string() + "/tank/" + GlobalVariables.get_current_age_as_string() + "_tank.tscn").instantiate()
	cave_tank.position = player_unit_spawn_position
	cave_tank.is_player_owned = true
	add_child(cave_tank)
	
	var cave_tank2 = load("res://units/" + GlobalVariables.get_current_age_as_string() + "/tank/" + GlobalVariables.get_current_age_as_string() + "_tank.tscn").instantiate()
	cave_tank2.position = Vector2(1400,570)
	cave_tank2.is_player_owned = false
	add_child(cave_tank2)
	


func _on_player_spawn_location_body_entered(body):
	if body.is_player_owned == true:
		unable_to_spawn = true


func _on_player_spawn_location_body_exited(body):
	if body.is_player_owned == true:
		unable_to_spawn = false
	
func spawn_random_projectiles_from_sky():
	var i = 0
	while i < 25:
		var projectile = load("res://projectile.tscn").instantiate()
		projectile.global_position = Vector2(randf_range(300, 1500), randf_range(-200, -1000))
		projectile.direction = Vector2(randf_range(-0.5, 0.5), randf_range(2, 4)).normalized()
		projectile.damage = 60
		projectile.speed = 300
		projectile.is_player_owned = true
		projectile.spawn_offspring = false
		projectile.time_to_die = 8.0
		projectile.get_node("Sprite2D").texture = load("res://age of war sprites/bases/medival/turret_3/medival_turret_3_projectile_offspring.png")
		get_node("/root/main_game").add_child(projectile)
		i += 1

func cave_special_attack():
	var i = 0
	while i < 25:
		var projectile = load("res://cave_special_projectile.tscn").instantiate()
		projectile.global_position = Vector2(randf_range(300, 1500), randf_range(-200, -1000))
		projectile.direction = Vector2(randf_range(-0.5, 0.5), randf_range(2, 4)).normalized()
		projectile.damage = 60
		projectile.speed = 300
		projectile.is_player_owned = true
		projectile.spawn_offspring = false
		projectile.time_to_die = 8.0
		projectile.get_node("Sprite2D").rotation = projectile.direction.angle()
		projectile.get_node("CPUParticles2D").direction = projectile.direction.normalized().rotated(PI/2)
		get_node("/root/main_game").add_child(projectile)
		i += 1

func knight_special_attack():
	var i = 0
	while i < 25:
		var projectile = load("res://projectile.tscn").instantiate()
		projectile.global_position = Vector2(randf_range(300, 1500), randf_range(-200, -1000))
		projectile.direction = Vector2(randf_range(-0.5, 0.5), randf_range(2, 4)).normalized()
		projectile.damage = 150
		projectile.speed = 400
		projectile.is_player_owned = true
		projectile.spawn_offspring = false
		projectile.time_to_die = 8.0
		projectile.get_node("Sprite2D").texture = load("res://age of war sprites/bases/miltary/turret_1/miltary_turret_1_projectile.png")
		projectile.get_node("Sprite2D").rotation = projectile.direction.angle()
		get_node("/root/main_game").add_child(projectile)
		i += 1

func medival_special_attack():
	pass

func miltary_special_attack():
	pass

func future_special_attack():
	pass
