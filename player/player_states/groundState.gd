extends State

class_name GroundState

@export var air_state: AirState
@export var grappling_state: GrapplingState

func state_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	character.animation_tree.set("parameters/move/blend_position", direction)
	if direction:
		character.velocity.x = direction * character.speed
		if (direction > 0):
			character.sprite.flip_h = false
		elif (direction < 0):
			character.sprite.flip_h = true
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.speed)
		
func state_input(event: InputEvent): 
	if event.is_action_pressed("jump"):
		jump()
	elif event.is_action_pressed("hook"):
		hookFunc()
			
func jump():
	#change animation to jump here
	#character.animation_tree.set("parameters/move/blend_position")
	character.velocity.y = character.jump_velocity
	next_state = air_state
	
func hookFunc():
	var end_point: Vector2 = character.get_global_mouse_position()
	var intersection_query = PhysicsRayQueryParameters2D.create(character.position, end_point)
	var intersection = character.get_world_2d().direct_space_state.intersect_ray(intersection_query)
	
	if not intersection.is_empty():
		character.hook_pos = intersection.values().pop_front()
		if character.position.distance_to(character.hook_pos) <= character.grapple_length:
			next_state = grappling_state

	##character.velocity.x = move_toward(character.velocity.x, 0, speed)

