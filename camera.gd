extends Camera2D

var velocity
var speed = 200
var left_most_position = 576
var right_most_position = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	self.limit_right = right_most_position + 576 
	velocity = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity != Vector2.ZERO:
		position.x += int(velocity.x * delta * speed)
	position.x = clamp(position.x, left_most_position, right_most_position)


func camera_shake(duration: float, intensity: float):
	pass

func stop_camera_moving():
	velocity = Vector2.ZERO

func _on_mouse_camera_move_left_mouse_entered():
	velocity = Vector2.LEFT


func _on_mouse_camera_move_right_mouse_entered():
	velocity = Vector2.RIGHT
