class_name Gun
extends Node3D

@export var damage: float = 0.0
@export var one_shot: bool = true
@export var fire_rate: float = 0.10
@export var infinite_magazine: bool = false
@export var magazine_size: int = 20
@export var reload_time: float = 2.0


func fire() -> void:
	pass


func reload() -> void:
	pass


func get_damage() -> float:
	return damage
