extends State

class_name AirState

@export var additional_jumps := 1
@export var jump_velocity := -200.0
@export var ground_state: GroundState

func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state


