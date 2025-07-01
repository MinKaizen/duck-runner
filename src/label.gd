extends Label

func _physics_process(delta: float) -> void:
	self.text  = str(get_parent().get_parent().state)
