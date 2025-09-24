extends Node2D

func set_value(value):
	$ProgressBar.value = value
	
func set_max(value):
	$ProgressBar.max_value = value
	
func set_step(value):
	$ProgressBar.step = value
