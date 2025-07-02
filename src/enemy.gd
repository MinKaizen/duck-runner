extends CharacterBody2D

const MOVE_SPEED = 200
const MOVE_DIRECTION = -1

func _ready() -> void:
	velocity.x = MOVE_DIRECTION * MOVE_SPEED

func _physics_process(_delta: float) -> void:
	move_and_slide()
