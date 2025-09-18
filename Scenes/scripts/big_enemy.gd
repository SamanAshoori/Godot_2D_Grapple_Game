extends CharacterBody2D

@onready var healthbar = $HealthBar
var health = 100

func _physics_process(delta: float) -> void:
	healthbar.set_max(100)
	healthbar.set_value(health)
