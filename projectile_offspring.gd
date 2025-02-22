extends Area2D

var damage: int = 10
@export var direction : Vector2 = Vector2(0,0)
var speed: float = 10
@export var time_to_die : float = 5.0
var is_player_owned: bool = true
var acceleration : Vector2 = Vector2(0, 20)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(time_to_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	direction += acceleration * delta
	if direction.y > 0:
		collision_mask = 1


func _on_timer_timeout():
	self.queue_free()


func _on_body_entered(body):
	if body is melee_unit or body is range_unit:
		if body.is_player_owned != self.is_player_owned:
			body.take_damage(damage)
			self.queue_free()
	elif body.name == "floor":
		self.queue_free()
