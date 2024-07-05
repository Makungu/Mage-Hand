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
	character.hook_pos = hook.get_collision_point()
	character.grapple_distance = character.position.distance_to(character.hook_pos)
	character.grapple_start_pos = character.global_position
	#character.velocity.x = move_toward(character.velocity.x, 0, speed)
	next_state = grappling_state
