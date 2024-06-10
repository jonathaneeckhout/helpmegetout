extends Node3D


func _ready():
	Game.started.connect(_on_game_started)


func _on_game_started():
	$AnimationPlayer.play("Open")
