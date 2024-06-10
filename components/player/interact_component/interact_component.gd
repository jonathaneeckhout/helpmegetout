class_name InteractComponent
extends Component

signal target_locked(target: Node3D)
signal target_lost(target: Node3D)

@export var interact_box: Area3D = null

## Key for interacting with a target
@export var interact_key: String = "interact"

var _target: Node3D = null


func _ready():
	interact_box.area_entered.connect(_on_area_entered)
	interact_box.area_exited.connect(_on_area_exited)


func _input(event):
	if event.is_action_pressed(interact_key) and _target != null:
		_target.interact()


func get_target() -> Node3D:
	return _target


func _on_area_entered(area: Area3D):
	var new_target: Node3D = area.get_parent()

	if new_target.get("interact") == null:
		return

	_target = new_target
	target_locked.emit(_target)


func _on_area_exited(_area: Area3D):
	if _target:
		target_lost.emit(_target)
	_target = null
