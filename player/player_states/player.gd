extends CharacterBody2D

@export var speed := 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var particles : Node2D
@export var particle_renderer : Node2D
var particle_vector := Vector3.ZERO
@onready var renderer := $render
@onready var rectifier = $Hand/CanvasLayer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
func particle_vector_process():
	particle_vector.x = velocity.x *-1
	particle_vector.y= velocity.y *-1

	particles.process_material.direction = particle_vector
	#particles.process_material.gravity = particle_vector
	#particles.process_material.directional_velocity_min = 100000
	#particles.process_material.directional_velocity_max = 100000
