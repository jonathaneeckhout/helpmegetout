class_name MainMenu
extends PanelContainer

signal singleplayer_pressed(map: String)
signal multiplayer_pressed

@onready var _singleplayer_button: Button = %SingleplayerButton
# @onready var _multiplayer_button: Button = %MultiplayerButton
@onready var _quit_button: Button = %QuitButton

@onready var _singleplayer_cellar_button: Button = %SingleplayerCellarButton
@onready var _singleplayer_back_button: Button = %SingleplayerBackButton


func _ready():
	_singleplayer_button.pressed.connect(_on_singleplayer_pressed)
	_quit_button.pressed.connect(_on_quit_button_pressed)

	_singleplayer_cellar_button.pressed.connect(_on_singleplayer_cellar_button_pressed)
	_singleplayer_back_button.pressed.connect(_on_singleplayer_back_button_pressed)


func _reset_view():
	%SingleplayerOverView.hide()
	%OverView.show()


func _on_singleplayer_pressed():
	%OverView.hide()
	%SingleplayerOverView.show()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_singleplayer_cellar_button_pressed():
	singleplayer_pressed.emit("cellar")
	_reset_view()


func _on_singleplayer_back_button_pressed():
	_reset_view()
