extends VBoxContainer

@export var shoot_component: ShootComponent = null


func _ready():
	shoot_component.fired.connect(_on_fired)
	shoot_component.reloaded.connect(_on_reloaded)

	_set_ammo()


func _set_ammo():
	var bullets: int = shoot_component.get_bullets()
	%Bullets.text = "%d : *" % [bullets]


func _on_fired():
	_set_ammo()


func _on_reloaded():
	_set_ammo()
