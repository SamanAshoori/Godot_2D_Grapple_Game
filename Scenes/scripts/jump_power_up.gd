extends Node2D

@onready var boost_timer = $boost_timer
var flash_tween: Tween

func _ready() -> void:
	play_floating_animation()


func play_floating_animation() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	var position_offset := Vector2(0.0, 4.0)
	var duration := randf_range(0.8, 1.2)
	tween.tween_property(self, "position", position_offset, duration).as_relative()
	tween.tween_property(self, "position", -position_offset, duration).as_relative()
	
	tween.set_loops()
	


#this is to detect player and increase jump boost
# This function is triggered when a body enters the Area2D.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		print('Power_Up On')
		body.JUMP_VELOCITY = -1500.0
		boost_timer.start()
		if body is CanvasItem:
			flash_tween = create_tween().set_loops()
			flash_tween.tween_property(body, "modulate", Color.YELLOW, 0.25)
			flash_tween.tween_property(body, "modulate", Color.WHITE, 0.25)
		self.hide()
		$Area2D.set_monitoring(false)


#once boost_timer is gone - it resets jump height and kills jump_velocity
func _on_boost_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.JUMP_VELOCITY = -550
		print("Jump velocity reset to original value.")
		if flash_tween:
			flash_tween.kill()
			if player is CanvasItem:
				player.modulate = Color.WHITE
