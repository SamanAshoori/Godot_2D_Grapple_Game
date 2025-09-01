extends Node2D

const SPEED: int = 400

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
 
 
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemy'):
		body.kill_enemy()
		queue_free()
		
	else:
		queue_free() # Replace with function body. # Replace with function body.
