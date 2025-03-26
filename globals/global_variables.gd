extends Node2D

var player_money
var player_exp

enum stage {cave, knight, medival, miltary, future}
var current_stage

enum difficulty {normal, hard, impossible}
var current_difficulty

# Called when the node enters the scene tree for the first time.
func _ready():
	player_money = 17500000
	player_exp = 4000000
	current_stage = stage.cave

func get_current_age_as_string():
	if current_stage == stage.cave:
		return "cave"
	elif current_stage == stage.knight:
		return "knight"
	elif current_stage == stage.medival:
		return "medival"
	elif current_stage == stage.miltary:
		return "miltary"
	elif current_stage == stage.future:
		return "future"

func _unhandled_key_input(event):
	if event.is_action_pressed("spacebar") and get_node("/root/main_game") != null and get_node("/root/main_game").process_mode == ProcessMode.PROCESS_MODE_INHERIT:
		get_node("/root/main_game").process_mode = ProcessMode.PROCESS_MODE_DISABLED
		get_node("/root/main_game/Camera2D/Label").show()
	elif event.is_action_pressed("spacebar") and get_node("/root/main_game") != null and get_node("/root/main_game").process_mode == ProcessMode.PROCESS_MODE_DISABLED:
		get_node("/root/main_game").process_mode = ProcessMode.PROCESS_MODE_INHERIT
		get_node("/root/main_game/Camera2D/Label").hide()

func get_unit_name(unit_type: String, input_stage):
	if input_stage == stage.cave:
		if unit_type == "melee":
			return "Club Man"
		elif unit_type == "range":
			return "Slingshot Man"
		elif unit_type == "tank":
			return "Dino Rider"
	elif input_stage == stage.knight:
		if unit_type == "melee":
			return "Sword Man"
		elif unit_type == "range":
			return "Archer"
		elif unit_type == "tank":
			return "Knight"
	elif input_stage == stage.medival:
		if unit_type == "melee":
			return "Dueler"
		elif unit_type == "range":
			return "Musketeer"
		elif unit_type == "tank":
			return "Cannoneer"
	elif input_stage == stage.miltary:
		if unit_type == "melee":
			return "Melee Infantry"
		elif unit_type == "range":
			return "Infantry"
		elif unit_type == "tank":
			return "Tank"
	elif input_stage == stage.future:
		if unit_type == "melee":
			return "God's Blade"
		elif unit_type == "range":
			return "Blaster"
		elif unit_type == "tank":
			return "War Machine"
		elif unit_type == "super_soldier":
			return "super soldier"

func get_unit_cost(unit_type: String, input_stage):
	if input_stage == stage.cave:
		if unit_type == "melee":
			return 15
		elif unit_type == "range":
			return 25
		elif unit_type == "tank":
			return 100
	elif input_stage == stage.knight:
		if unit_type == "melee":
			return 50
		elif unit_type == "range":
			return 75
		elif unit_type == "tank":
			return 500
	elif input_stage == stage.medival:
		if unit_type == "melee":
			return 200
		elif unit_type == "range":
			return 400
		elif unit_type == "tank":
			return 1000
	elif input_stage == stage.miltary:
		if unit_type == "melee":
			return 1500
		elif unit_type == "range":
			return 2000
		elif unit_type == "tank":
			return 7000
	elif input_stage == stage.future:
		if unit_type == "melee":
			return 5000
		elif unit_type == "range":
			return 6000
		elif unit_type == "tank":
			return 20000


func get_turret_name(query_stage, turret_number: int):
	if query_stage == stage.cave:
		if turret_number == 1:
			return "Rock Slingshot"
		elif turret_number == 2:
			return "Egg Automatic"
		elif turret_number == 3:
			return "Primitive Catapult"
	elif query_stage == stage.knight:
		if turret_number == 1:
			return "Catapult"
		elif turret_number == 2:
			return "Fire Catapult"
		elif turret_number == 3:
			return "Oil"
	elif query_stage == stage.medival:
		if turret_number == 1:
			return "Small Cannon"
		elif turret_number == 2:
			return "Large Cannon"
		elif turret_number == 3:
			return "Explosive Cannon"
	elif query_stage == stage.miltary:
		if turret_number == 1:
			return "Single Turret"
		elif turret_number == 2:
			return "Rocket Launcher"
		elif turret_number == 3:
			return "Double Turret"
	elif query_stage == stage.future:
		if turret_number == 1:
			return "Titanium Shooter"
		elif turret_number == 2:
			return "Laser Cannon"
		elif turret_number == 3:
			return "Ion Cannon"


func get_stage_from_string(string: String):
	if string == "cave":
		return stage.cave
	elif string == "knight":
		return stage.knight
	elif string == "medival":
		return stage.medival
	elif string == "miltary":
		return stage.miltary
	elif string == "future":
		return stage.future

func get_turret_price(query_stage, turret_number: int):
	if query_stage == stage.cave:
		if turret_number == 1:
			return 100
		elif turret_number == 2:
			return 200
		elif turret_number == 3:
			return 500
	elif query_stage == stage.knight:
		if turret_number == 1:
			return 500
		elif turret_number == 2:
			return 750
		elif turret_number == 3:
			return 1000
	elif query_stage == stage.medival:
		if turret_number == 1:
			return 1500
		elif turret_number == 2:
			return 3000
		elif turret_number == 3:
			return 6000
	elif query_stage == stage.miltary:
		if turret_number == 1:
			return 7500
		elif turret_number == 2:
			return 9000
		elif turret_number == 3:
			return 14000
	elif query_stage == stage.future:
		if turret_number == 1:
			return 24000
		elif turret_number == 2:
			return 40000
		elif turret_number == 3:
			return 100000
	
	
func get_exp_to_next_age():
	if current_stage == stage.cave:
		return 4000
	elif current_stage == stage.knight:
		return 14000
	elif current_stage == stage.medival:
		return 45000
	elif current_stage == stage.miltary:
		return 200000
	elif current_stage == stage.future:
		return INF
