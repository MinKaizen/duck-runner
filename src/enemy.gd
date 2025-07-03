extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	velocity = Global.move_velocity
	move_and_slide()
