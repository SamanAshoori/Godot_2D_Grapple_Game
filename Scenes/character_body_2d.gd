extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const ACCELERATION = 0.1
const DECELERATION = 0.1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = lerp(velocity.x, SPEED * direction,ACCELERATION)
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		velocity.x =lerp(velocity.x, 0.0 ,DECELERATION)
	
	
	move_and_slide()
	
	

func kill_player():
	position = %RespawnPoint.position
	get_tree().reload_current_scene()
	Global.score = 0
	print('player_died')

func _on_death_zone_body_entered(body: Node2D) -> void:
	kill_player()
	
