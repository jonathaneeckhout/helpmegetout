class_name GuardedDoor
extends StaticBody3D

@export var guardians: Array[Enemy] = []

func _ready():
	for guardian in guardians:
		var health_component: HealthComponent = guardian.get_node("ComponentList/HealthComponent")
		if health_component == null:
			continue
		
		health_component.died.connect(_on_died)


func _open():
	$AnimationPlayer.play("Open")
	collision_layer = 0


func _check_guardians():
	# Loop backwards
	for i in range(guardians.size() - 1, -1, -1):
		var guardian: Enemy = guardians[i]
		if not is_instance_valid(guardian):
			guardians.remove_at(i)

		var health_component: HealthComponent = guardian.get_node("ComponentList/HealthComponent")
		if health_component.is_dead:
			guardians.remove_at(i)
	
	if guardians.is_empty():
		_open()


func _on_died():
	_check_guardians()
