class_name Rifle
extends Gun

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func fire() -> void:
	_animation_player.play("Fire")
