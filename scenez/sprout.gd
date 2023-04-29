extends CharacterBody2D


@export var Speed: int = 300.0
@onready var life: float = 3.0
@onready var animations = $Sprite2D/AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * Speed
	
func endScene():
	get_tree().change_scene_to_file("res://scenez/died.tscn")
		
func updateHealth():
	
	if life < 3 and life > 0:
		$ouchBox/CollisionShape2D.set_deferred("disabled", true) 
		$Sprite2D.hide()
		$hurt.show()
		$hurt/AnimationPlayer.play("ouchiee")
		await $hurt/AnimationPlayer.animation_finished
		$ouchBox/CollisionShape2D.set_deferred("disabled", false) 
		$hurt.hide()
		$hurt/AnimationPlayer.pause()
		$Sprite2D.show()
	if life == 0:
		endScene()
		
	
func updateParticles():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false	
		
func updateAnimation():
	if Input.is_action_just_pressed("left"):
		animations.play("base")
		scale.y = 1
		rotation_degrees = 0
	elif Input.is_action_just_pressed("right"):
		animations.play("base")
		scale.y = -1
		rotation_degrees = 180
	elif Input.is_action_just_pressed("blueAttack"):
		animations.play("attack")
		await animations.animation_finished
		animations.play("base")
	elif Input.is_action_just_pressed("pinkAttack"):
		animations.play("attack")
		await animations.animation_finished
		animations.play("base")
	elif Input.is_action_just_pressed("yellAttack"):
		animations.play("attack")
		await animations.animation_finished
		animations.play("base")
	elif Input.is_action_just_pressed("dash"):
		animations.play("dashTrans")	
		await animations.animation_finished
		animations.play("dash")
	else: 
		pass

func _physics_process(delta):
	handleInput()
	updateAnimation()
	updateParticles()
	move_and_slide()



func _on_ouch_box_body_entered(body):
	updateHealth()
	life -= .25
	
	print(life)
