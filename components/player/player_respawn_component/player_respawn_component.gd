class_name PlayerRespawnComponent
extends Component

signal respawned

@export var respawn_time: float = 3.0

var _respawn_timer: Timer = null

@onready var _health_component: HealthComponent = $"../HealthComponent"


func _ready():
	super._ready()

	_health_component.died.connect(_on_died)

	_respawn_timer = Timer.new()
	_respawn_timer.name = "RespawnTimer"
	_respawn_timer.autostart = false
	_respawn_timer.one_shot = true
	_respawn_timer.wait_time = respawn_time
	_respawn_timer.timeout.connect(_on_respawn_timer_timeout)
	add_child(_respawn_timer)

func get_respawn_timer_timeleft() -> float:
	return _respawn_timer.time_left

func _respawn(location: Vector3):
	actor.hide()
	_health_component.reset()
	actor.position = location
	actor.velocity = Vector3.ZERO
	actor.show()
	
	respawned.emit()


func _on_died():
	GodotLogger.info("%s died, starting respawn timer" % actor.name)
	_respawn_timer.start()


func _on_respawn_timer_timeout():
	var respawn_location: Vector3 = Game.get_map().find_player_respawn_location(actor.position)

	GodotLogger.info(
		(
			"Respawning %s at position (%d,%d,%d)"
			% [actor.name, respawn_location.x, respawn_location.y, respawn_location.z]
		)
	)

	_respawn(respawn_location)
