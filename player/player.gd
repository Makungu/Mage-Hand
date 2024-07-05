extends CharacterBody2D

@export var speed := 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hook_pos: Vector2 = Vector2.ZERO
var grapple_distance: float = 0.0
var grapple_start_pos: Vector2 = Vector2.ZERO
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()
	
