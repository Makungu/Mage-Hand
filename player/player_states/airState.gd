extends State

class_name AirState

@export var jumps_remaining := 1
@export var ground_state: GroundState
@export var grappling_state: GrapplingState

func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state

func state_input(event: InputEvent):
	if event.is_action_pressed("move_left"):
		jump()
	if event.is_action_pressed("jump") and jumps_remaining > 0:
		jump()
	elif event.is_action_pressed("hook"):
		hookFunc()
		
func jump():
	character.velocity.y = character.jump_velocity
	jumps_remaining -= 1
	
func hookFunc():
	var end_point: Vector2 = character.get_global_mouse_position()
	var intersection_query = PhysicsRayQueryParameters2D.create(character.position, end_point)
	var intersection = character.get_world_2d().direct_space_state.intersect_ray(intersection_query)
	
	if not intersection.is_empty():
		character.hook_pos = intersection.values().pop_front()
		if character.position.distance_to(character.hook_pos) <= character.grapple_length:
			next_state = grappling_state
	
func on_exit():
	if next_state == ground_state:
		jumps_remaining = 1
	
