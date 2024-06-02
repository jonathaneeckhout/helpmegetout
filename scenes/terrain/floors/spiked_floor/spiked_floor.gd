extends Node3D

@onready var kill_box: Area3D = $KillBox


func _ready():
	kill_box.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D):
	var player: CharacterBody3D = area.get_parent()

	# TODO: possible add enemies here as well
	if not player is Player:
		return

	var health_component: HealthComponent = player.component_list.get_component("health_component")
	if health_component.is_dead:
		return

	health_component.kill()
