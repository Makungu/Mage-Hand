extends State

class_name GrapplingState

@export var jump_velocity = -400.0
@export var speed := 4.0
@export var air_state: AirState
@export var ground_state: GroundState

@onready var ray_cast = $"../../Node2D/RayCast2D"

var damping: float = 0.995 
var angular_velocity: float = 0.0
var angular_acceleration: float = 0.0
var angle: float = 0.0
var radius: float = 0.0

func on_enter():
	character.draw_circle(character.hook_pos, 10.0, Color.RED)
	radius = Vector2.ZERO.distance_to(character.grapple_start_pos - ray_cast.get_collision_point())
	angle = Vector2.ZERO.angle_to(character.grapple_start_pos - ray_cast.get_collision_point())
	angular_velocity = 0.0
	angular_acceleration = 0.0
	print(ray_cast.get_collision_point())

func state_process(delta):
	# here we need some logic to determine if the grappling hook is still colliding with 
	# a surface if yes continue to swing else change states
	if !Input.is_action_just_released("hook"):
		# may be worth adding something like this instead of the below check and incoperate the direction into the position 
		# calculations
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			angle += angular_velocity
			angular_acceleration = ((-character.gravity*delta)/radius) * sin(angle)
			angular_velocity += angular_acceleration
			angular_velocity *= damping
			angular_velocity += direction * 0.02
			character.position = Vector2(radius*sin(angle), radius*cos(angle)) + character.hook_pos
	else:
		# resect accumulative delta here, next grappling hook should start fresh
		if character.is_on_floor():
			next_state = ground_state
			# logic here to rotate player to be flat on ground
		elif !character.is_on_floor():
			next_state = air_state
	
func on_exit():
	radius = 0.0
	angle = 0.0
