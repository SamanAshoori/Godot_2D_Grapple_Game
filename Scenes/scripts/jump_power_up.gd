extends Node2D


func _ready() -> void:
	play_floating_animation()


func play_floating_animation() -> void:
	var tween := create_tween()
	# Optional: make the animation a bit smoother
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	var position_offset := Vector2(0.0, 4.0)
	var duration := randf_range(0.8, 1.2)

	# Chain .as_relative() to treat the position_offset as a relative move
	tween.tween_property(self, "position", position_offset, duration).as_relative()
	tween.tween_property(self, "position", -position_offset, duration).as_relative()
	
	tween.set_loops()
