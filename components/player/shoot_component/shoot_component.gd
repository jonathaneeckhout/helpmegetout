class_name ShootComponent
extends Component

## The gun used for shooting
@export var gun: Gun = null
## Raycast to detect hitscan targets
@export var hit_scan_raycast: RayCast3D = null
## Key for shooting
@export var shoot_key: String = "shoot"

var _shoot_key_pressed: bool = false
var _shoot_delay_timer: Timer = null


func _ready():
	super._ready()

	_shoot_delay_timer = Timer.new()
	_shoot_delay_timer.name = "ShootDelayTimer"
	_shoot_delay_timer.one_shot = true
	_shoot_delay_timer.autostart = false
	add_child(_shoot_delay_timer)


func _input(event):
	if event.is_action_pressed(shoot_key):
		_shoot_key_pressed = true
	elif event.is_action_released(shoot_key):
		_shoot_key_pressed = false


func _physics_process(_delta):
	if _shoot_key_pressed:
		if gun != null:
			gun.fire()

			_shoot()


func _shoot():
	# Wait until delay is done before firing again
	if not _shoot_delay_timer.is_stopped():
		return

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
