class_name Projectile
extends Node3D

const MAX_ALIVE_TIME: float = 10.0


var movement_speed: float = 0.0
var damage: float = 0.0
var target_position: Vector3 =  Vector3.ZERO
var velocity: Vector3 = Vector3.FORWARD

var _destroy_timer: Timer = null

@onready var hurt_box: Area3D = $HurtBox

func _ready():
	_destroy_timer = Timer.new()
	_destroy_timer.name = "DestroyTimer"
	_destroy_timer.autostart = true
	_destroy_timer.one_shot = true
	_destroy_timer.wait_time = MAX_ALIVE_TIME
	_destroy_timer.timeout.connect(_on_destroy_timer_timeout)
	add_child(_destroy_timer)

	hurt_box.area_entered.connect(_on_hurt_box_area_entered)
	
	look_at(target_position)
	velocity = position.direction_to(target_position)


func _physics_process(delta):
	position +=  velocity * movement_speed * delta

func _on_destroy_timer_timeout():
	queue_free()

func _on_hurt_box_area_entered(area: Area3D):
	var body: Node3D = area.get_parent()

	if body.get("component_list") == null:
		return

	var health_component: HealthComponent = body.component_list.get_component("health_component")
	if health_component == null:
		return
	
	health_component.take_damage(damage)
	queue_free()
