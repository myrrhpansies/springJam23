extends CharacterBody2D
var chase = false
var killable = false
var alive = true
@export var movement_speed : float = 150.0
@export var movement_target : Node
@export var navigation_agent: NavigationAgent2D


func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	$enemyAttention.attentive.connect(madeAware)
	$enemyAttention.weak.connect(weakened)
	$enemyAttention.notWeak.connect(unWeakened)
	
func madeAware():
	chase = true
	print("hey there")
	

func notAware():
	if !chase and !killable and alive:
		if	movement_target.position.x > self.position.x:
			$sprites.flip_h = true
		if	movement_target.position.x < self.position.x:
			$sprites.flip_h = false		

func weakened():
	killable = true


func unWeakened():
	killable = false	


func timeToDIe():
	if killable and Input.is_action_just_pressed("baseAttack"):
		alive = false
		chase = false
		$sprites/Animation.play("Death")
		await $sprites/Animation.animation_finished
		queue_free()
	
func actor_setup():
	if chase:
		await get_tree().physics_frame
		set_movement_target(movement_target.position)
		$sprites/Animation.play("Attack")
		if	movement_target.position.x > self.position.x:
			$sprites.flip_h = true
		if	movement_target.position.x < self.position.x:
			$sprites.flip_h = false	

func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point




func _physics_process(_delta):
	notAware()
	timeToDIe()
	if navigation_agent.is_navigation_finished() and chase:
		actor_setup()

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = next_path_position - current_agent_position
		
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed
		
	velocity = new_velocity
	move_and_slide()
