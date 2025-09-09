extends Node2D
const BULLET = preload("res://Scenes/bullet.tscn")
@onready var muzzle: Marker2D = $muzzle
@onready var timer := $Timer
var is_ready: bool = true

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees,0,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	if Input.is_action_just_pressed("fire") and is_ready:
		is_ready = false
		$Timer.start()
		var bullet_instance = BULLET.instantiate()
		$gun_fire.play()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = rotation


func _on_timer_timeout() -> void:
	is_ready = true #resets gun cooldown
