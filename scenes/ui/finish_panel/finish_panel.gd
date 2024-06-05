extends PanelContainer

@onready var _exit_button: Button = %ExitButton


func _ready():
	Game.finished.connect(_on_game_finished)
	_exit_button.pressed.connect(_on_exit_button_pressed)


func _on_game_finished(time: float):
	%FinishTime.text = "%02d:%02d:%02d" % [floor(time / 60), int(time) % 60, int(time * 100) % 100]
	show()


func _on_exit_button_pressed():
	Game.exited.emit()
