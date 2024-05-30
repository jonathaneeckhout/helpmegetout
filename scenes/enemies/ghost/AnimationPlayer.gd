extends AnimationPlayer

@onready var _health_component: HealthComponent = $"../ComponentList/HealthComponent"
@onready
var _attack_and_wander_component: AttackAndWanderComponent = $"../ComponentList/AttackAndWanderComponent"


# Called when the node enters the scene tree for the first time.
func _ready():
	_health_component.died.connect(_on_died)
	_attack_and_wander_component.attacked.connect(_on_attacked)


func _on_died():
	stop()
	play("Die")


func _on_attacked():
	stop()
	play("Attack")
