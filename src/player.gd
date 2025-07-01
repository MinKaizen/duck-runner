extends CharacterBody2D

const GRAVITY = 980.0
const JUMP_VELOCITY = -400.0
const JUMP_HOLD_MULTIPLIER = 0.5

func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta

	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
