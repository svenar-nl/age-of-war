extends Node2D

var direction
var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2.RIGHT
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > 200:
		self.queue_free()
	elif position.x > 100:
		$bomb_timer.stop()
	pass



func spawn_bomb():
	print("spawn bomb")


func _on_bomb_timer_timeout():
	spawn_bomb()
