extends Node2D

@export var rest_length = 2.0
@export var stiffness = 10.0
@export var damping = 2.0
@export var jump_force = 200.0 # Jump force added

@onready var ray := $RayCast2D
@onready var player := get_parent()
@onready var rope := $Line2D
@onready var timer := $Timer
var launched = false
var target: Vector2
var is_ready: bool = true

func _process(delta):
	ray.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("grapple") and is_ready:
		is_ready = false
		$Timer.start()
		launch()
	if Input.is_action_just_released("grapple"):
		retract()
		
	if launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()	
		rope.show()
		
func retract():
	# Only apply jump force if we were actually grappling
	if launched:
		# Set the player's upward velocity
		player.velocity.y = -jump_force
		
	launched = false
	rope.hide()
	
func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	var displacement = target_dist - rest_length
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping_force = -damping * vel_dot * target_dir
		
		# Add forces together
		force = spring_force + damping_force

	player.velocity += force * delta
	update_rope()

func update_rope():
	rope.set_point_position(1,to_local(target))


func _on_timer_timeout() -> void:
	is_ready = true # set ready back to true.
