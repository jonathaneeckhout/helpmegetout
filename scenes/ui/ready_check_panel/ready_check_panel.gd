extends PanelContainer

@export var game_component: GameComponent = null

@onready var _ready_button: Button = %ReadyButton


func _ready():
	_ready_button.pressed.connect(_on_ready_pressed)


func _on_ready_pressed():
	hide()
	game_component.set_ready()
