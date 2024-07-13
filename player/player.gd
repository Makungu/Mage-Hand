extends CharacterBody2D

@export var speed := 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hook_pos: Vector2 = Vector2.ZERO
var grapple_distance: float = 0.0
var grapple_start_pos: Vector2 = Vector2.ZERO
var grapple_length: float = 300

@onready var hook_ray_cast: RayCast2D = $Node2D/RayCast2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

@export var particles : Node2D
@export var particle_renderer : Node2D
var particle_vector := Vector3.ZERO
@onready var renderer := $render
@onready var rectifier = $Hand/CanvasLayer


func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func particle_vector_process():
	particle_vector.x = velocity.x *-1
	particle_vector.y= velocity.y *-1

	particles.process_material.direction = particle_vector
	#particles.process_material.gravity = particle_vector
	#particles.process_material.directional_velocity_min = 100000
	#particles.process_material.directional_velocity_max = 100000
