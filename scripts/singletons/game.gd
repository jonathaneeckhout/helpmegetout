extends Node

signal finished(time: float)

var time_passed: float = 0.0
var is_running: bool = false

var _map: Map = null


func start() -> bool:
	if is_running:
		GodotLogger.warn("Can not start game. Game is already running")
		return false

	time_passed = 0.0
	is_running = true

	return true


func stop() -> bool:
	if not is_running:
		GodotLogger.warn("Can not stop game. Game is not running")
		return false

	is_running = false
	return true


func load_map(map: Map):
	if map != null and map.all_players_finished.is_connected(_on_all_players_finished):
		map.all_players_finished.disconnect(_on_all_players_finished)

	_map = map
	_map.all_players_finished.connect(_on_all_players_finished)


func get_map() -> Map:
	return _map


func _physics_process(delta: float):
	if is_running:
		time_passed += delta


func _on_all_players_finished():
	if is_running:
		stop()
		finished.emit(time_passed)
