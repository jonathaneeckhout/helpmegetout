class_name ShootComponent
extends Component

@export var gun: Gun = null

@export var hit_scan_raycast: RayCast3D = null

## Key for shooting
@export var shoot_key: String = "shoot"

var _shoot_key_pressed: bool = false


func _input(event):
	if event.is_action_pressed(shoot_key):
		_shoot_key_pressed = true


func _physics_process(_delta):
	if _shoot_key_pressed:
		_shoot_key_pressed = false

		if gun != null:
			gun.fire()

			_shoot()


func _shoot():
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
