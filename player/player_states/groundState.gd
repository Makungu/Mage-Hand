extends State

class_name GroundState

@export var jump_velocity := -400.0
@export var speed := 300.0
@export var air_state: AirState
@export var grappling_state: GrapplingState
@onready var hook = $"../../Node2D/RayCast2D"

func state_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	character.animation_tree.set("parameters/move/blend_position", direction)
	if direction:
		character.velocity.x = direction * speed
		if (direction > 0):
			character.sprite.flip_h = false
		elif (direction < 0):
			character.sprite.flip_h = true
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
		
func state_input(event: InputEvent): 
	if event.is_action_pressed("jump"):
		jump()
	elif event.is_action_pressed("hook"):
		hookFunc()
			
func jump():
	#change animation to jump here
	#character.animation_tree.set("parameters/move/blend_position")
	character.velocity.y = jump_velocity
	next_state = air_state
	
func hookFunc():
	var end_point: Vector2 = character.get_global_mouse_position()
	var intersection_query = PhysicsRayQueryParameters2D.create(character.position, end_point)
	var intersection = character.get_world_2d().direct_space_state.intersect_ray(intersection_query)
	
	if not intersection.is_empty():
		#var a = intersection.values().pop_front()
		end_point.clamp()
		character.hook_pos = intersection.values().pop_front() * -character.grapple_length
		next_state = grappling_state
		
	#character.grapple_distance = character.position.distance_to(character.hook_pos)
	#character.grapple_start_pos = character.global_position
	##character.velocity.x = move_toward(character.velocity.x, 0, speed)
	#next_state = grappling_state
