class_name Map
extends Node3D

signal all_players_finished

@onready var players: Node3D = $Players
@onready var projectiles: Node3D = %Projectiles
@onready var finish_area: FinishArea = $FinishArea
@onready var player_respawn_locations = $PlayerRespawnLocations


func _ready():
	finish_area.player_entered.connect(_on_player_entered_finish_area)
	finish_area.player_exited.connect(_on_player_exited_finish_area)


func find_player_respawn_location(player_position: Vector3) -> Vector3:
	var spots = player_respawn_locations.get_children()

	if len(spots) == 0:
		GodotLogger.warn("No player respawn spots found, returning current player's position")
		return player_position

	var closest = spots[0].position
	var closest_distance = closest.distance_to(player_position)

	for spot in spots:
		var distance = spot.position.distance_to(player_position)
		if distance < closest_distance:
			closest = spot.position
			closest_distance = distance

	return closest


func _check_all_players_finished():
	if players.get_child_count() == finish_area.total_players_entered:
		all_players_finished.emit()


func _on_player_entered_finish_area(_player: Player):
	_check_all_players_finished()


func _on_player_exited_finish_area(_player: Player):
	_check_all_players_finished()
