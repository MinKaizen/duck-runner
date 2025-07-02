extends Node2D

const ROCK_SCENE = preload('res://src/rock.tscn')
const CACTUS_SCENE = preload('res://src/cactus.tscn')
const MAX_WAIT_TIME = 2
const MIN_WAIT_TIME = 0.5
const ENEMIES = [
	ROCK_SCENE,
	CACTUS_SCENE,
]

@onready var timer = %Timer


func _ready() -> void:
	spawn_enemy()
	timer.connect('timeout', spawn_enemy)

func spawn_enemy() -> void:
	var enemy = ENEMIES[randi_range(0, ENEMIES.size() - 1)].instantiate()
	enemy.position = self.global_position
	get_parent().add_child(enemy)
	timer.wait_time = randf_range(MIN_WAIT_TIME, MAX_WAIT_TIME)
	timer.start()
