class_name CameraComponent
extends Component

## The node (head usually) containing the main camera
@export var head: Node3D = null

## Mouse sensitivity of the player.
@export var mouse_sensitivity: float = 0.4


func _ready():
	super._ready()


# Handles mouse motion input to rotate the player and look up and down.
func _input(event):
	if event is InputEventMouseMotion:
		# Rotate the player around the axis.
		actor.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		# Look up and down.
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

		# Ensure not to look too far.
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
