extends CharacterBody2D

enum State {
	GROUNDED,
	JUMPING,
	FALLING
}

const GRAVITY = 1300.0
const JUMP_VELOCITY = -300.0
const JUMP_HOLD_ACCELERATION = -800
const MAX_JUMP_TIME = 0.5

var state = State.FALLING
var jump_buffer_timer = 0.0
var jump_hold_timer = 0.0
var jump_started = false
var jump_state_elapsed = 0

@onready var hitbox = %Hitbox

func _ready() -> void:
	hitbox.connect('body_entered', on_hit)

func on_hit(body: Node2D) -> void:
	print("hit!")
	print(body)

func _physics_process(delta: float):
	match state:
		State.GROUNDED:
			handle_grounded_state(delta)
		State.JUMPING:
			handle_jumping_state(delta)
		State.FALLING:
			handle_falling_state(delta)
	move_and_slide()


func handle_grounded_state(_delta):
	if Input.is_action_just_pressed('jump'):
		velocity.y = JUMP_VELOCITY
		state = State.JUMPING

func handle_jumping_state(delta):
	jump_state_elapsed += delta
	velocity.y += (GRAVITY + JUMP_HOLD_ACCELERATION) * delta
	if not Input.is_action_pressed("jump"):
		state = State.FALLING
		jump_state_elapsed = 0
	if jump_state_elapsed >= MAX_JUMP_TIME:
		state = State.FALLING
		jump_state_elapsed = 0

func handle_falling_state(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		velocity.y = 0
		state = State.GROUNDED
