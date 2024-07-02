extends State

class_name GrapplingState

@export var jump_velocity = -400.0
@export var speed := 300.0
@export var air_state: AirState
@export var ground_state: GroundState

var is_grappling := true
var accumulative_delta := 0.0

func state_process(delta):
	# here we need some logic to determine if the grappling hook is still colliding with 
	# a surface if yes continue to swing else change states
	accumulative_delta += delta
	if is_grappling:
		# may be worth adding something like this instead of the below check and incoperate the direction into the position 
		# calculation
		# var direction = Input.get_axis("move_left", "move_right")
		# if direction:
		if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"):
			# mathematical calculation of the player position based on rotation
			var x = character.position.x * cos(delta * speed) - character.position.y * sin(delta * speed)
			var y = character.position.x * sin(delta * speed) + character.position.y * cos(delta * speed)
			character.position = Vector2(x, y)
	else:
		# resect accumulative delta here, next grappling hook should start fresh
		accumulative_delta = 0
		if character.is_on_floor():
			next_state = ground_state
			# logic here to rotate player to be flat on ground
		elif !character.is_on_floor():
			next_state = air_state
	
