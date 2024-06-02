class_name MovementComponent
extends Component

## Run speed of the player.
@export var run_speed: float = 7.0

## Sprint speed of the player.
@export var sprint_speed: float = 10.0

## Jump speed of the player.
@export var jump_speed: float = 5.0

## Key for moving up.
@export var up_key: String = "move_up"

## Key for moving down.
@export var down_key: String = "move_down"

## Key for moving left.
@export var left_key: String = "move_left"

## Key for moving right.
@export var right_key: String = "move_right"

## Key for jumping
@export var jump_key: String = "jump"

var input_direction: Vector2 = Vector2.ZERO
var direction: Vector3 = Vector3.ZERO

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var _health_component: HealthComponent = $"../HealthComponent"


func _physics_process(delta):
	# Don't do anything else than falling when not on the floor
	if not actor.is_on_floor():
		actor.velocity.y -= _gravity * delta
		actor.move_and_slide()
		return

	if not _health_component.is_dead:
		# Handle jump.
		if Input.is_action_just_pressed(jump_key) and actor.is_on_floor():
			actor.velocity.y = jump_speed

		input_direction = Input.get_vector(left_key, right_key, up_key, down_key)
		direction = (
			(actor.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
		)

		# If input is detected, apply it to the velocity.
		if direction:
			actor.velocity.x = direction.x * run_speed
			actor.velocity.z = direction.z * run_speed
		# If not, slow down.
		else:
			actor.velocity.x = move_toward(actor.velocity.x, 0, run_speed) * delta
			actor.velocity.z = move_toward(actor.velocity.z, 0, run_speed) * delta
	# Slow down when dead
	else:
		actor.velocity.x = move_toward(actor.velocity.x, 0, run_speed) * delta
		actor.velocity.z = move_toward(actor.velocity.z, 0, run_speed) * delta

	actor.move_and_slide()
