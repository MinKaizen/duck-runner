extends Node2D

@onready var parallax: Parallax2D = %Parallax2D

func _ready() -> void:
	parallax.autoscroll = Global.move_velocity
