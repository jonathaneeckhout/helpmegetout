class_name Map
extends Node3D

signal all_players_finished

@onready var players: Node3D = $Players
@onready var finish_area: FinishArea = $FinishArea


func _ready():
	finish_area.player_entered.connect(_on_player_entered_finish_area)
	finish_area.player_exited.connect(_on_player_exited_finish_area)


func _check_all_players_finished():
	if players.get_child_count() == finish_area.total_players_entered:
		all_players_finished.emit()


func _on_player_entered_finish_area(_player: Player):
	_check_all_players_finished()


func _on_player_exited_finish_area(_player: Player):
	_check_all_players_finished()
