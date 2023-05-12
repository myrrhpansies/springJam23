extends CharacterBody2D
var chase = false
@export var movement_speed : float = 200.0
@export var movement_target : CharacterBody2D
@export var navigation_agent: NavigationAgent2D


func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	$interact.Change.connect(madeAware)
	
func madeAware():
	chase = true

func actor_setup():
	if chase:
		await get_tree().physics_frame
		set_movement_target(movement_target.position)

func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point

func _physics_process(_delta):
	
	if navigation_agent.is_navigation_finished():
		actor_setup()
		
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
		
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed
		
	velocity = new_velocity
	move_and_slide()
