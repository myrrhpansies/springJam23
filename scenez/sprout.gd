extends CharacterBody2D


@export var Speed: int = 300.0
@onready var life: int = 5
@onready var animations = $Sprite2D/AnimationPlayer

func _ready():
	Global.player = self

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * Speed
	
func endScene():
	get_tree().change_scene_to_file("res://scenez/died.tscn")
		
func updateHealth():
#	$ouchBox/CollisionShape2D.set_deferred("disabled", true) 
	if life < 5 and life > 0:
		$Sprite2D.hide()
		$hurt.show()
		$hurt/AnimationPlayer.play("ouchiee")
		await $hurt/AnimationPlayer.animation_finished
		$hurt.hide()
		$hurt/AnimationPlayer.pause()
		$Sprite2D.show()
#		$ouchBox/CollisionShape2D.set_deferred("disabled", false) 
#		life -= .25
	if life == 0:
		$Sprite2D.hide()
		$hurt.show()
		$hurt/AnimationPlayer.play("ouchiee")
		await $hurt/AnimationPlayer.animation_finished
		endScene()
	
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
	move_and_slide()


func _on_ouch_box_body_entered(body):
	$ouchBox/CollisionShape2D.set_deferred("disabled", true)
	life -= 1
	updateHealth()
	$ouchBox/Timer.start()
	print(life)
	

func _on_timer_timeout():
	$ouchBox/CollisionShape2D.set_deferred("disabled", false)
	print('time out')
