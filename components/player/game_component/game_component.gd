class_name GameComponent
extends Component

@export var is_ready: bool = false

@onready var _movement_component: MovementComponent = $"../MovementComponent"
@onready var _camera_component: CameraComponent = $"../CameraComponent"
@onready var _shoot_component: ShootComponent = $"../ShootComponent"


func _ready():
	super._ready()
	Component.disable_component(_movement_component)
	Component.disable_component(_camera_component)
	Component.disable_component(_shoot_component)

	Game.started.connect(_on_game_started)
	Game.stopped.connect(_on_game_stopped)
	Game.finished.connect(_on_game_finished)


func set_ready():
	Component.enable_component(_camera_component)

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	is_ready = true
	Game.set_player_ready()


func _on_game_started():
	Component.enable_component(_movement_component)
	Component.enable_component(_shoot_component)


func _on_game_stopped():
	await get_tree().create_timer(1).timeout
	Component.disable_component(_movement_component)
	Component.disable_component(_shoot_component)


func _on_game_finished(_time: float):
	Component.disable_component(_camera_component)

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
