class_name MovingFloor
extends Node3D

@export var curve: Curve3D:
	set(v):
		curve = v
		$Path3D.curve = v

@export_range(0.0, 2) var speed_scale: float = 1.0:
	set(v):
		speed_scale = v
		$AnimationPlayer.speed_scale = v

@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D
