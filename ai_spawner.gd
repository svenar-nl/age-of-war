extends Node2D


var current_age

enum phase1_states {spawn_m, spawn_mm, spawn_mmm}
enum phase2_states {spawn_mr=3, spawn_mmr=4, spawn_mrr=5, spawn_mmrr=6}
enum phase3_states {spawn_t=7, spawn_tr=8, spawn_ttr=9}
var current_state

var enemy_units_container

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position.y = 570
	
	current_age = "cave"
	$Timer.start(3.0)
	enemy_units_container = get_node("/root/main_game/enemy_units")
	$Timer2.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



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
	# Choose new state
	var random_value = randi_range(1, 3)
	$Timer.wait_time = randf_range(3.0, 5.0)
	print(random_value)
	if random_value == 1:
		spawn_melee()
	elif random_value == 2:
		spawn_range()
	elif random_value == 3:
		spawn_tank()
	elif random_value == 4:
		pass
	elif random_value == 5:
		pass
	elif random_value == 6:
		pass
	elif random_value == 7:
		pass
	elif random_value == 8:
		pass
	elif random_value == 9:
		pass
	elif random_value == 10:
		pass
	


func _on_area_2d_body_entered(body):
	$Timer.stop()
	



func _on_area_2d_body_exited(body):
	$Timer.start()


func _on_timer_2_timeout():
	print("change age")
	if current_age == "cave":
		current_age = "knight"
		$Timer2.stop()
		$Timer2.wait_time = 120
		$Timer2.start()
	elif current_age == "knight":
		current_age = "medival"
	elif current_age == "medival":
		current_age = "miltary"
	elif current_age == "miltary":
		current_age = "future"
		$Timer2.stop()
