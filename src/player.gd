extends CharacterBody2D

signal died

enum State {
	GROUNDED,
	JUMPING,
	FALLING,
	FLYING,
}

const GRAVITY = 2000.0
const FLY_ACCELERATION = -400.0
const FLY_DOWN_THRESHOLD = 190.0
const FLY_UP_THRESHOLD = -220.0
const JUMP_VELOCITY = -700.0

var state = State.FALLING:
	set(value):
		state = value
		match value:
			State.GROUNDED:
				velocity.y = 0
			State.JUMPING:
				velocity.y = JUMP_VELOCITY

@onready var hitbox = %Hitbox

func _ready() -> void:
	hitbox.connect('body_entered', on_hit)

func on_hit(_body: Node2D) -> void:
	print("died")
	died.emit()

func _physics_process(delta: float):
	match state:
		State.GROUNDED:
			handle_grounded_state(delta)
		State.JUMPING:
			handle_jumping_state(delta)
		State.FALLING:
			handle_falling_state(delta)
		State.FLYING:
			handle_flying_state(delta)
	move_and_slide()

func handle_grounded_state(_delta):
	if Input.is_action_just_pressed('jump'):
		state = State.JUMPING

func handle_jumping_state(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		state = State.GROUNDED
	if velocity.y >= FLY_DOWN_THRESHOLD and Input.is_action_pressed('jump'):
		state = State.FLYING
	elif velocity.y >= FLY_DOWN_THRESHOLD:
		state = State.FALLING

func handle_flying_state(delta):
	velocity.y += FLY_ACCELERATION * delta
	if is_on_floor():
		state = State.GROUNDED
	if velocity.y <= FLY_UP_THRESHOLD:
		state = State.FALLING
	if not Input.is_action_pressed('jump'):
		state = State.FALLING

func handle_falling_state(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		state = State.GROUNDED
