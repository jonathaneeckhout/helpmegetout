class_name Component
extends Node

@export var actor: Node3D = null

var _component_list: ComponentList = null


func _ready():
	register_to_parent_list()


func register_to_parent_list():
	var parent: Node = get_parent()

	if not parent is ComponentList:
		GodotLogger.error("Must be the child of a ComponentList")

	_component_list = parent
	_component_list.register_component(self)


static func disable_component(component: Component):
	component.set_physics_process(false)
	component.set_process_input(false)


static func enable_component(component: Component):
	component.set_physics_process(true)
	component.set_process_input(true)
