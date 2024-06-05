extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.finished.connect(_on_game_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_game_finished(time: float):
	%FinishTime.text = "%02d:%02d:%02d" % [floor(time / 60), int(time) % 60, int(time * 100) % 100]
	show()
