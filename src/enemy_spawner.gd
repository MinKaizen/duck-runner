extends Node2D

const ROCK_SCENE = preload('res://src/rock.tscn')

@onready var timer = %Timer

func _ready() -> void:
	timer.connect('timeout', on_timer_timeout)

func on_timer_timeout() -> void:
	print('spawner timeout')
	var rock = ROCK_SCENE.instantiate()
	rock.position = self.global_position
	get_tree().current_scene.add_child(rock)

