extends Node2D

@export var is_player_owned: bool = true

var projectile_damge

var current_state
enum state {idle, attack}

var target_queue: Array
var current_target
# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = state.idle
	
	for child in get_node("sfx").get_children():
		child.bus = &'sfx'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_queue.size() > 0:
		current_target = target_queue[0]
		# print(current_target.get_node("CollisionShape2D").global_position)
		if current_target == null or current_target.get_node("CollisionShape2D").disabled == true:
			target_queue.pop_front()
			return
		
		var target_position :Vector2 = current_target.get_node("CollisionShape2D").global_position - self.global_position
		$Line2D.set_point_position(1, target_position)
		
		if $AnimatedSprite2D.get_animation() == "idle":
			$AnimatedSprite2D.play("attack")
			
		# self.global_position.angle_to_point(current_target.get_node("CollisionShape2D").global_position - self.global_position)
		$AnimatedSprite2D.rotation = target_position.angle()
		
		if $AnimatedSprite2D.frame == 5:
			spawn_projectile(target_position.normalized())
		elif $AnimatedSprite2D.frame == 1 and $sfx/AudioStreamPlayer2D.is_playing() == false:
			$sfx/AudioStreamPlayer2D.play()
	else:
		$AnimatedSprite2D.play("idle")
	pass


func _on_range_body_entered(body):
	if body is melee_unit or body is range_unit:
		if body.is_player_owned != is_player_owned:
			target_queue.append(body)

func spawn_projectile(direction):
	var projectile = load("res://projectile.tscn").instantiate()
	projectile.global_position = self.global_position
	projectile.direction = direction
	projectile.damage = 15
	projectile.speed = 400
	projectile.is_player_owned = self.is_player_owned
	projectile.get_node("Sprite2D").texture = load("res://age of war sprites/bases/cave/turret_1/cave_turret_1_projectile_01.png")
	get_node("/root/main_game").add_child(projectile)
