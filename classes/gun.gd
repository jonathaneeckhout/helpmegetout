class_name Gun
extends Node3D

@export var damage: float = 0.0
@export var one_shot: bool = true
@export var fire_rate: float = 0.10


func fire() -> void:
	pass


func get_damage() -> float:
	return damage
