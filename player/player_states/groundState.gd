extends State

class_name GroundState

@export var jump_velocity = -400.0
@export var speed := 300.0
@export var air_state: AirState

func state_input(event: InputEvent): 
	if event.is_action_pressed("jump"):
		jump()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	
