extends CharacterBody2D

const ROCK_SCENE = preload("res://Scenes/rock.tscn")
@onready var player_detection_ray = $Player_Detection
@onready var shoot_timer = $rock_cooldown
@onready var projectile_spawn_point = $rock_marker
@onready var healthbar = $HealthBar
const MAX_HEALTH = 100.0
var health = 100
var moving_right = 1
const SPEED = 25
var canSwitch = true
var player = null

func _physics_process(delta: float) -> void:
	
	if player:
		player_detection_ray.target_position = to_local(player.global_position)
		var collider = player_detection_ray.get_collider()
		if collider == player and shoot_timer.is_stopped():
			shoot()
			shoot_timer.start()
	
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
		projectile_spawn_point.position = Vector2(-40,0)
		$RayCast2D.target_position = Vector2(-50,50)
	else:
		velocity.x = SPEED * 1
		$AnimatedSprite2D.flip_h = false
		projectile_spawn_point.position = Vector2(40,0)
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
		
func shoot():
	var rock = ROCK_SCENE.instantiate()
	var shoot_direction = (player.global_position - projectile_spawn_point.global_position).normalized()
	rock.global_position = projectile_spawn_point.global_position
	rock.direction = shoot_direction
	get_tree().root.add_child(rock)


func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body # Replace with function body.


func _on_detection_zone_body_exited(body: Node2D) -> void:
	# If the body that left is the same one we are tracking, forget it.
	if body == player:
		player = null # Replace with function body.
