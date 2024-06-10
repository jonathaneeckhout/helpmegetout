class_name LerverLockedDoor
extends Node3D

@export var lervers: Array[Lerver] = []

var _opened: bool = false


func _ready():
	for lerver in lervers:
		lerver.toggled.connect(_on_toggled)


func _open():
	$AnimationPlayer.play("Open")


func _check_lervers():
	if _opened:
		return

	var lervers_on: int = 0

	for lerver in lervers:
		if lerver.enabled:
			lervers_on += 1

	if lervers_on == lervers.size():
		_open()


func _on_toggled(_on: bool):
	_check_lervers()
