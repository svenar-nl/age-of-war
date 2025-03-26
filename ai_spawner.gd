extends Node2D


var current_age

enum phase {m, r, t}
var current_phase = phase.m

var enemy_units_container

signal change_age

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position.y = 570
	
	current_age = "cave"
	$Timer.start(3.0)
	enemy_units_container = get_node("/root/main_game/enemy_units")
	$Timer2.start()
	$Timer3.start()



func spawn_melee():
	var cave_melee2 = load("res://units/" + current_age + "/melee/" + current_age + "_melee.tscn").instantiate()
	cave_melee2.position = self.global_position
	cave_melee2.is_player_owned = false
	enemy_units_container.add_child(cave_melee2)

func spawn_range():
	var cave_range2 = load("res://units/" + current_age + "/range/" + current_age + "_range.tscn").instantiate()
	cave_range2.position = self.global_position
	cave_range2.is_player_owned = false
	enemy_units_container.add_child(cave_range2)

func spawn_tank():
	var cave_tank2 = load("res://units/" + current_age + "/tank/" + current_age + "_tank.tscn").instantiate()
	cave_tank2.position = self.global_position
	cave_tank2.is_player_owned = false
	enemy_units_container.add_child(cave_tank2)
	
func buy_turret():
	pass
	
func add_turret_spot():
	pass
	
func sell_turret():
	pass
	
func advance_to_next_age():
	if current_age == "cave":
		current_age = "knight"
	elif current_age == "knight":
		current_age = "medival"
	elif current_age == "medival":
		current_age = "miltary"
	elif current_age == "miltary":
		current_age = "future"


func _on_timer_timeout():
	var random_value = randi_range(1, 3)
	if random_value == 1:
		spawn_melee()
		$Timer.wait_time = randf_range(2.0, 4.0)
	elif random_value == 2:
		spawn_range()
		$Timer.wait_time = randf_range(2.0, 4.0)
	elif random_value == 3:
		spawn_tank()
		$Timer.wait_time = randf_range(4.0, 6.0)

	


func _on_area_2d_body_entered(body):
	$Timer.stop()
	

func _on_area_2d_body_exited(body):
	$Timer.start()

func _on_timer_2_timeout():
	emit_signal("change_age")
	if current_age == "cave":
		current_age = "knight"
		$Timer2.wait_time = 150
	elif current_age == "knight":
		current_age = "medival"
		$Timer2.wait_time = 160
	elif current_age == "medival":
		current_age = "miltary"
		$Timer2.wait_time = 170
	elif current_age == "miltary":
		current_age = "future"
		$Timer2.stop()


func _on_timer_3_timeout():
	# print("spawn turret")
	# get_node("/root/main_game/enemy_base")
	# MAYBE A TODO for Later
	$Timer3.wait_time += 60
