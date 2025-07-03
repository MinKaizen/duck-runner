extends Node2D

enum State {
	GAME,
	GAME_OVER,
	IDLE,
}

var state = State.IDLE

@onready var player = %Player
@onready var game_over_screen = %GameOver
@onready var idle_screen = %Idle
@onready var game = %Game

func _ready() -> void:
	player.connect('died', on_player_died)
	get_tree().paused = true

func on_player_died() -> void:
	if (state == State.GAME_OVER):
		return
	state = State.GAME_OVER
	get_tree().paused = true
	game_over_screen.visible = true

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed('jump') :
		return
	if state == State.IDLE:
		idle_screen.visible = false
		state = State.GAME
		get_tree().paused = false
	if state == State.GAME_OVER:
		state = State.GAME
		game_over_screen.visible = false
		reset_game()

func reset_game() -> void:
	var tree = get_tree()
	tree.paused = false
	var enemies = tree.get_nodes_in_group('enemy')
	for enemy in enemies:
		enemy.queue_free()



