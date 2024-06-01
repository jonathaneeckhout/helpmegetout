extends PanelContainer

@export var health_component: HealthComponent = null
@export var player_respawn_component: PlayerRespawnComponent = null

@onready var _time_label: Label = %TimeLabel


func _ready():
	set_process(false)
	health_component.died.connect(_on_died)
	player_respawn_component.respawned.connect(_on_respawned)

func _process(_delta):
	var time_left: float = player_respawn_component.get_respawn_timer_timeleft()
	_time_label.text = "%02d:%02d" % [floor(time_left / 60), int(time_left) % 60]


func _on_died():
	show()
	set_process(true)

func _on_respawned():
	hide()
	set_process(false)
