extends Area3D


func _ready():
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D):
	var body: Node3D = area.get_parent()

	if body.get("component_list") == null:
		return

	var health_component: HealthComponent = body.component_list.get_component("health_component")
	if health_component == null:
		return

	health_component.kill()
