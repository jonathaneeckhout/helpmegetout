class_name InteractionPreview
extends VBoxContainer

@export var interact_component: InteractComponent = null


func _ready():
	interact_component.target_locked.connect(_on_target_locked)
	interact_component.target_lost.connect(_on_target_lost)


func _on_target_locked(target: Node3D):
	show()
	if target.get("display_name") != null:
		%Target.text = target.display_name
	else:
		%Target.text = target.name


func _on_target_lost(_target: Node3D):
	hide()
	%Target.text = ""
