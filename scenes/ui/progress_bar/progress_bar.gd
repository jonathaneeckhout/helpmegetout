extends VBoxContainer

@onready var _time_label: Label = %TimeLabel


func _process(_delta):
	if not Game.is_running:
		return

	_time_label.text = ("%02d:%02d" % [floor(Game.time_passed / 60), int(Game.time_passed) % 60])
