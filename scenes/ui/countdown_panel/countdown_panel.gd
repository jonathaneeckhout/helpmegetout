extends PanelContainer


@onready var _time_label: Label = %TimeLabel

func _ready():
	set_process(false)
	Game.countdown_started.connect(_on_countdown_started)
	Game.countdown_stopped.connect(_on_countdown_stopped)


func _process(_delta):
	var time_left: float = Game.get_countdown_timer_timeleft()
	_time_label.text = "%02d:%02d" % [floor(time_left / 60), int(time_left) % 60]


func _on_countdown_started():
	set_process(true)
	show()


func _on_countdown_stopped():
	set_process(false)
	hide()
