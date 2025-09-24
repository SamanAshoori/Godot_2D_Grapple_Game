extends CharacterBody2D

@onready var healthbar = $HealthBar
const MAX_HEALTH = 100.0
var health = 100
var moving_right = 1
const SPEED = 25
var canSwitch = true

func _physics_process(delta: float) -> void:
	
	healthbar.set_value(health)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$RayCast2D.is_colliding() and canSwitch:
		moving_right *= -1
		canSwitch = false
	else:
		canSwitch = true
	
	if moving_right < 0:
		velocity.x = SPEED * -1
		
		$AnimatedSprite2D.flip_h = true
		$RayCast2D.target_position = Vector2(-50,50)
	else:
		velocity.x = SPEED * 1
		$AnimatedSprite2D.flip_h = false
		$RayCast2D.target_position = Vector2(50,50)
		
	$AnimatedSprite2D.play("walk")
	move_and_slide()

func _ready() -> void:
	healthbar.set_max(MAX_HEALTH)
	healthbar.set_step(10)


func take_damage(amount: float) -> void:
	health -= amount
	# Clamp the health to prevent it from going below zero or above max.
	health = clamp(health, 0, MAX_HEALTH)
	# Update the UI only when health changes.
	healthbar.set_value(health)
	print('big enemy health = ' + str(health))
	
	if health <= 0:
		# Handle death here (e.g., queue_free()).
		print("Big Enemy died!")
		queue_free()
