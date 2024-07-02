extends Node2D
@onready var ray_cast = $RayCast2D

func _input(event):
	if event.is_action_pressed("hook"):
		look_at(get_global_mouse_position())
	
