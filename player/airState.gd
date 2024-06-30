extends State

class_name AirState

@export var jumps_remaining := 1
@export var jump_velocity := -200.0
@export var ground_state: GroundState

func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state

func state_input(event: InputEvent):
	if event.is_action_pressed("jump") and jumps_remaining > 0:
		jump()
		
func jump():
	character.velocity.y = jump_velocity
	jumps_remaining -= 1
	
func on_exit():
	if next_state == ground_state:
		jumps_remaining = 1
	
