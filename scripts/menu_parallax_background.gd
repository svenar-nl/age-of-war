extends ParallaxBackground

func _ready() -> void:
	update_parallax()

func _process(delta) -> void:
	update_parallax()

func update_parallax() -> void:
	var mouse_position = get_viewport().get_mouse_position() / 10
	scroll_offset = mouse_position
