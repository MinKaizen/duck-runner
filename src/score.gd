extends Control

var score = 0.0:
	set(value):
		score = value
		var score_rounded = roundi(score)
		score_text = "Score: %010d" % score_rounded
var score_text = "Score: %010d" % 0
var speed = 10

@onready var label = %Label

func reset() -> void:
	score = 0

func _physics_process(delta: float) -> void:
	score += delta * speed
	label.text = score_text


