extends melee_unit

var hit_sfx: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 300
	damage = 80
	move_speed = 50
	
	sprite_walk_position = Vector2(40, -70)
	sprite_idle_position = Vector2(31, -70)
	sprite_die_position = Vector2(30, -61)
	sprite_attack_position = Vector2(45, -69)
	
	hit_sfx = get_node("sfx/hit_sfx")
	money_die_reward = 650
	
	super()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func attack_state():
	if $RayCast2D.is_colliding() == false:
		change_state(state.walk)
		stop_all_sfx()
		return
	
	if $AnimatedSprite2D.frame == 18:
		hit_sfx.play()
		# whack_sfx.pitch_scale = randf_range(0.9, 1.1)
	if $AnimatedSprite2D.frame == 20:
		do_damage($RayCast2D.get_collider())
