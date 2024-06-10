class_name Lerver
extends StaticBody3D

signal toggled(on: bool)

const TIMEOUT_TIME: float = 1.0

@export var display_name: String = "Lerver"

@export var enabled: bool = false

@onready var _animation_player: AnimationPlayer = $AnimationPlayer

var _timeout_timer: Timer = null


func _ready():
	_timeout_timer = Timer.new()
	_timeout_timer.name = "TimeoutTimer"
	_timeout_timer.autostart = false
	_timeout_timer.one_shot = true
	_timeout_timer.wait_time = TIMEOUT_TIME
	add_child(_timeout_timer)


func toggle():
	if not _timeout_timer.is_stopped():
		return

	_timeout_timer.start()

	enabled = !enabled

	if enabled:
		_animation_player.play("TurnOn")
	else:
		_animation_player.play("TurnOff")

	toggled.emit(enabled)


func interact():
	toggle()
