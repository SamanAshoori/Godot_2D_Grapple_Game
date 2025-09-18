extends CharacterBody2D

@onready var healthbar = $HealthBar
const MAX_HEALTH = 100.0

var health = 100.0

func _ready() -> void:
	healthbar.set_max(MAX_HEALTH)

func _physics_process(delta: float) -> void:
	healthbar.set_value(health)
	take_damage(0.5)

func take_damage(amount: float) -> void:
	health -= amount
	# Clamp the health to prevent it from going below zero or above max.
	health = clamp(health, 0, MAX_HEALTH)
	# Update the UI only when health changes.
	healthbar.set_value(health)
	
	if health <= 0:
		# Handle death here (e.g., queue_free()).
		print("Big Enemy died!")
		queue_free()
