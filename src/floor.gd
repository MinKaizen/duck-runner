extends Parallax2D

func _physics_process(delta: float) -> void:
	position.x -= 20 * delta
