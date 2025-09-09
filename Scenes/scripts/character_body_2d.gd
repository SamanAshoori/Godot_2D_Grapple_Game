extends CharacterBody2D

var Health = 30
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const ACCELERATION = 0.1
const DECELERATION = 0.1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#Handle 0 Health
	if Health == 0:
		kill_player()

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
	
func player_hit():
	Health -= 10;
	$".".set_modulate('RED')
	print(Health)
	$Hit_timer.start()

func kill_player():
	position = %RespawnPoint.position
	get_tree().reload_current_scene()
	Global.score = 0
	print('player_died')

func _on_death_zone_body_entered(body: Node2D) -> void:
	kill_player()
	


func _on_hit_timer_timeout() -> void:
	$".".set_modulate('#ffffff') # Replace with function body.
