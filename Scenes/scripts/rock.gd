extends Area2D

var direction = Vector2.ZERO # The direction will be set by the enemy.
const SPEED = 350

func _physics_process(delta):
	# Move the rock in its set direction every frame.
	global_position += direction * SPEED * delta

# Optional: You can connect the 'body_entered' signal of the Area2D
# to this script to make the rock disappear when it hits the player or a wall.
func _on_body_entered(body):
	if body.is_in_group("player"):
		# Add damage logic here if you want.
		pass
	queue_free() # Destroy the rock.
