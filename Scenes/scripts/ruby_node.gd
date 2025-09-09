extends Node2D



func _on_area_2d_area_entered(area: Area2D) -> void:
	print('Item detected')


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group('player'):
		print('Player Detected') 
		Global.score += 1;
		queue_free()
	
