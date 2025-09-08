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
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.kill_player() # Replace with function body.
