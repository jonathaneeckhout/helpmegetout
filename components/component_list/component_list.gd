class_name ComponentList
extends Node

@export var actor: Node3D = null

var _components: Dictionary = {}


func _ready():
	if actor == null:
		GodotLogger.error("Actor is null")
		return


func register_component(component: Component) -> void:
	var component_identifier: String = ComponentList.get_component_identifier(component)
	# var new_arr: Array[Component] = []

	component.actor = actor

	if _components.has(component_identifier):
		GodotLogger.error("Component already registered under this list.")
		return

	_components[component_identifier] = component


func get_component(comp_identifier: String) -> Component:
	return _components.get(comp_identifier, null)


static func get_component_identifier(component: Component) -> String:
	var regex = RegEx.new()
	# regex remove ".gd" from the end of the file name
	regex.compile("(.+).gd")
	var result = regex.search(component.get_script().resource_path.get_file())
	return result.get_string(1)
