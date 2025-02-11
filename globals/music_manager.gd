extends Node2D


var audioStreamPlayer : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	audioStreamPlayer = get_node("AudioStreamPlayer")
	audioStreamPlayer.play()
	audioStreamPlayer.bus = &'Music'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
