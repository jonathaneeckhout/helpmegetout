extends Node3D

@onready var _maps: Node3D = %Maps
@onready var _main_menu: MainMenu = %MainMenu


func _ready():
	_main_menu.singleplayer_pressed.connect(_on_singleplayer_pressed)


func _load_map(map_name: String):
	var map_scene: PackedScene = load("res://scenes/maps/%s/%s.tscn" % [map_name, map_name])
	var map: Map = map_scene.instantiate()
	map.name = "map_name"
	_maps.add_child(map)

	Game.load_map(map)


func _on_singleplayer_pressed(map: String):
	_load_map(map)
	_main_menu.hide()
