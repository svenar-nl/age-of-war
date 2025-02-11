extends Node2D

var player_money
var player_exp

enum stage {cave, knight, medival, miltary, future}
var current_stage

# Called when the node enters the scene tree for the first time.
func _ready():
	player_money = 175
	player_exp = 0
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
