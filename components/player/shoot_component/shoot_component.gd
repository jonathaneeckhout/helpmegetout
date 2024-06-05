class_name ShootComponent
extends Component

signal fired
signal reloading
signal reloaded

## The gun used for shooting
@export var gun: Gun = null
## Raycast to detect hitscan targets
@export var hit_scan_raycast: RayCast3D = null
## Key for shooting
@export var shoot_key: String = "shoot"
## Key for reloading
@export var reload_key: String = "reload"

var _shoot_key_pressed: bool = false
var _reload_key_pressed: bool = false

var _shoot_delay_timer: Timer = null
var _reload_delay_timer: Timer = null

@onready var _health_component: HealthComponent = $"../HealthComponent"

var _bullets: int = 0


func _ready():
	super._ready()

	_shoot_delay_timer = Timer.new()
	_shoot_delay_timer.name = "ShootDelayTimer"
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.autostart = false
	add_child(_shoot_delay_timer)

	_reload_delay_timer = Timer.new()
	_reload_delay_timer.name = "ReloadDelayTimer"
	_reload_delay_timer.one_shot = true
	_reload_delay_timer.autostart = false
	_reload_delay_timer.timeout.connect(_on_reload_timer_timeout)
	add_child(_reload_delay_timer)

	if gun:
		_bullets = gun.magazine_size


func _input(event):
	if event.is_action_pressed(shoot_key):
		_shoot_key_pressed = true
	elif event.is_action_released(shoot_key):
		_shoot_key_pressed = false
	elif event.is_action_pressed(reload_key):
		_reload_key_pressed = true


func _physics_process(_delta):
	if _health_component.is_dead:
		return

	if _shoot_key_pressed:
		if gun != null:
			_shoot()

	if _reload_key_pressed:
		_reload()
		_reload_key_pressed = false


func get_bullets() -> int:
	return _bullets


func _reload() -> bool:
	if gun == null:
		return false

	# Signal used for reloading animation
	reloading.emit()

	gun.reload()

	_reload_delay_timer.start(gun.reload_time)

	return true


func _shoot():
	# Wait until delay is done before firing again
	if not _shoot_delay_timer.is_stopped():
		return

	# Can't shoot while reloading
	if not _reload_delay_timer.is_stopped():
		return

	# Check if there are enough bullets in the magazine
	if _bullets <= 0:
		return false

	# Use one bullet
	_bullets -= 1

	fired.emit()

	gun.fire()

	_shoot_delay_timer.start(gun.fire_rate)

	hit_scan_raycast.force_raycast_update()

	if not hit_scan_raycast.is_colliding():
		return

	var collider: Object = hit_scan_raycast.get_collider()

	if not collider is Area3D:
		return

	var target: Node3D = collider.get_parent()

	if not target is Enemy:
		return

	var enemy: Enemy = target

	var damage: float = gun.get_damage()

	var health_component: HealthComponent = enemy.component_list.get_component("health_component")

	if not health_component.is_dead:
		health_component.take_damage(damage)


func _on_reload_timer_timeout():
	_bullets = gun.magazine_size
	reloaded.emit()
