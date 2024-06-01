class_name FinishArea
extends Area3D

signal player_entered(player: Player)
signal player_exited(player: Player)

var total_players_entered: int = 0


func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _on_area_entered(area: Area3D):
	var node: Node = area.get_parent()
	if node is Player:
		total_players_entered += 1
		player_entered.emit(node)


func _on_area_exited(area: Area3D):
	var node: Node = area.get_parent()
	if node is Player:
		total_players_entered -= 1
		player_exited.emit(node)
