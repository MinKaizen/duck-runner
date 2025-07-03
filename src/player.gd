extends CharacterBody2D

signal died

enum State {
	GROUNDED,
	JUMPING,
	LONG_JUMPING,
	FALLING,
	FLYING,
}

const GRAVITY = 2500.0
const FLY_ACCELERATION = -400.0
const FLY_DOWN_THRESHOLD = 190.0
const FLY_UP_THRESHOLD = -220.0
const JUMP_VELOCITY = -500.0
const MAX_JUMP_DURATION = 0.5
const LONG_JUMP_GRAVITY = 900.0

var state = State.FALLING:
	set(value):
		if value != state:
			match state:
				State.FLYING:
					fly_sound.stop()
					fly_sound.seek(0)
		state = value

		match value:
			State.GROUNDED:
				velocity.y = 0
				did_long_jump = false
				is_long_jumping = false
				long_jump_elapsed = 0.0
			State.FLYING:
				fly_sound.seek(0)
				fly_sound.play()
			State.JUMPING:
				jump_sound.seek(0)
				jump_sound.pitch_scale = randf_range(0.5, 0.8)
				jump_sound.play()
				velocity.y = JUMP_VELOCITY
				if Input.is_action_pressed('jump'):
					is_long_jumping = true
					did_long_jump = true

var did_long_jump = false
var is_long_jumping = false
var long_jump_elapsed = 0.0

@onready var hitbox = %Hitbox
@onready var jump_sound = %JumpSound
@onready var fly_sound = %FlySound

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
		State.LONG_JUMPING:
			handle_long_jumping_state(delta)
		State.FALLING:
			handle_falling_state(delta)
		State.FLYING:
			handle_flying_state(delta)
	move_and_slide()

func handle_grounded_state(_delta):
	if Input.is_action_just_pressed('jump'):
		state = State.JUMPING

func handle_jumping_state(delta):
	if is_long_jumping:
		velocity.y += LONG_JUMP_GRAVITY * delta
		long_jump_elapsed += delta
	else:
		velocity.y += GRAVITY * delta
	
	if long_jump_elapsed >= MAX_JUMP_DURATION:
		is_long_jumping = false
	
	if Input.is_action_just_released('jump'):
		is_long_jumping = false

	if is_on_floor():
		state = State.GROUNDED
	if velocity.y >= FLY_DOWN_THRESHOLD and Input.is_action_pressed('jump'):
		state = State.FLYING
	elif velocity.y >= FLY_DOWN_THRESHOLD:
		state = State.FALLING

func handle_long_jumping_state(delta):
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
