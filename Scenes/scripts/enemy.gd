extends CharacterBody2D

var moving_right = 1
const SPEED = 25
var canSwitch = true

func _physics_process(delta: float) -> void:
	
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
	

func kill_enemy():
	#This is some spaghetti ass shit in order to make sure that
	#the player doesnt get stuck nor die while waiting for sound to end
	#fun
	$death_sound.play()
	$".".visible = false
	$".".collision_mask = 3
	$".".collision_layer = 3
	$Area2D/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	$Area2D.monitoring = false
	$Area2D.collision_layer = 3
	$Area2D.collision_mask = 3
	print("kill_enemy() started")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.player_hit() #player loses 10hp


func _on_death_sound_finished() -> void:
	print("Death sound finished, queuing for deletion")
	queue_free() # Replace with function body.
