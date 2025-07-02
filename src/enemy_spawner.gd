extends Node2D

const ROCK_SCENE = preload('res://src/rock.tscn')
const MAX_WAIT_TIME = 2
const MIN_WAIT_TIME = 0.2

@onready var timer = %Timer


func _ready() -> void:
	timer.wait_time = 0.1
	timer.connect('timeout', on_timer_timeout)

func on_timer_timeout() -> void:
	var rock = ROCK_SCENE.instantiate()
	rock.position = self.global_position
	get_parent().add_child(rock)
	timer.wait_time = randf_range(MIN_WAIT_TIME, MAX_WAIT_TIME)

