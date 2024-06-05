extends Node

signal countdown_started
signal countdown_stopped
signal started
signal stopped
signal finished(time: float)
signal exited

const COUNTDOWN_TIME: float = 3.0

var time_passed: float = 0.0
var is_running: bool = false

var _map: Map = null
var _players_ready: int = 0

var _countdown_timer: Timer = null


func _ready():
	_countdown_timer = Timer.new()
	_countdown_timer.name = "CountdownTimer"
	_countdown_timer.autostart = false
	_countdown_timer.one_shot = true
	_countdown_timer.timeout.connect(_on_countdown_timer_timeout)
	add_child(_countdown_timer)


func start() -> bool:
	if is_running:
		GodotLogger.warn("Can not start game. Game is already running")
		return false

	time_passed = 0.0
	_players_ready = 0

	_countdown_timer.start(COUNTDOWN_TIME)
	countdown_started.emit()

	return true


func stop() -> bool:
	if not is_running:
		GodotLogger.warn("Can not stop game. Game is not running")
		return false

	is_running = false

	stopped.emit()
	return true


func load_map(map: Map):
	clear_map()

	_map = map
	_map.all_players_finished.connect(_on_all_players_finished)


func clear_map():
	if _map != null and _map.all_players_finished.is_connected(_on_all_players_finished):
		_map.all_players_finished.disconnect(_on_all_players_finished)

	_map = null
	time_passed = 0.0
	_players_ready = 0


func get_map() -> Map:
	return _map


func get_countdown_timer_timeleft() -> float:
	return _countdown_timer.time_left


func set_player_ready():
	_players_ready += 1
	if _players_ready == _map.players.get_child_count():
		GodotLogger.info("Starting the game with %d player('s)" % _players_ready)
		start()


func _physics_process(delta: float):
	if is_running:
		time_passed += delta


func _on_all_players_finished():
	if is_running:
		stop()
		finished.emit(time_passed)


func _on_countdown_timer_timeout():
	is_running = true
	countdown_stopped.emit()
	started.emit()
