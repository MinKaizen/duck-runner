extends Node2D

enum State {
	MAIN,
	GAME_OVER,
}

var state = State.MAIN

@onready var player = %Player
@onready var game_over_screen = %GameOverScreen

func _ready() -> void:
	player.connect('died', on_player_died)

func on_player_died() -> void:
	if (state == State.GAME_OVER):
		return
	state = State.GAME_OVER
	get_tree().paused = true
	game_over_screen.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('jump') and state == State.GAME_OVER:
		get_tree().paused = false
		get_tree().reload_current_scene()

