class_name AttackAndWanderComponent
extends Component

signal attacked

@export var aggro_box: Area3D = null:
	set(value):
		aggro_box = value
		_attack_behavior.aggro_box = value

@export var hit_box: Area3D = null:
	set(value):
		hit_box = value
		_attack_behavior.hit_box = value

@export var navigation_agent: NavigationAgent3D = null:
	set(value):
		navigation_agent = value
		_attack_behavior.navigation_agent = value
		_wander_behavior.navigation_agent = value

## The speed of which the actor will move towards it's target
@export var aggro_movement_speed: float = 7.0:
	set(value):
		aggro_movement_speed = value
		_attack_behavior.aggro_movement_speed = value

@export var attack_speed: float = 1.0:
	set(value):
		attack_speed = value
		_attack_behavior.attack_speed = value

@export var minimum_attack_power: float = 5.0:
	set(value):
		minimum_attack_power = value
		_attack_behavior.minimum_attack_power = attack_speed

@export var maximum_attack_power: float = 10.0:
	set(value):
		maximum_attack_power = value
		_attack_behavior.maximum_attack_power = value

## How fast the actor should wander
@export var wander_speed: float = 5.0:
	set(value):
		wander_speed = value
		_wander_behavior.wander_speed = value

## The distance from the starting position the parent can wander
@export var wander_distance: float = 20.0:
	set(value):
		wander_distance = value
		_wander_behavior.wander_distance = value

## The time the parent should stay idle before wandering
@export var idle_time: float = 10.0:
	set(value):
		idle_time = value
		_wander_behavior.idle_time = value

var _attack_behavior: AttackBehavior = AttackBehavior.new()
var _wander_behavior: WanderBehavior = WanderBehavior.new()

var _health_component: HealthComponent = null


func _ready():
	super._ready()

	_health_component = get_node("../HealthComponent")

	_attack_behavior.actor = actor
	_attack_behavior.name = "AttackBehavior"
	add_child(_attack_behavior)

	_wander_behavior.actor = actor
	_wander_behavior.name = "WanderBehavior"
	add_child(_wander_behavior)


func _physics_process(delta: float):
	if _health_component.is_dead:
		return
	behavior(delta)


func behavior(delta: float):
	if _attack_behavior.has_target():
		_attack_behavior.attack(delta)
	else:
		_wander_behavior.wander(delta)
