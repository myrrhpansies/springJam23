extends CharacterBody2D


@export var Speed: int = 300
@onready var life: int = 5
@onready var animations = $Sprite2D/AnimationPlayer
@onready var honkmation = $honkDetector/AnimatedSprite2D

func _ready():
	Global.player = self

func handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * Speed
	
func endScene():
	get_tree().change_scene_to_file("res://scenez/died.tscn")
		
func updateHealth():
	if life < 5 and life > 0:
		$Sprite2D.hide()
		$hurt.show()
		$hurt/AnimationPlayer.play("ouchiee")
		await $hurt/AnimationPlayer.animation_finished
		$hurt.hide()
		$hurt/AnimationPlayer.pause()
		$Sprite2D.show()
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
	
func honkAbout():
	if Input.is_action_just_pressed("blueAttack"):
		honkmation.show()
		honkmation.play("blueHorn")
		await honkmation.animation_finished
		honkmation.hide()
		honkmation.pause()
		print("done")
	elif Input.is_action_just_pressed("yellAttack"):
		honkmation.show()
		honkmation.play("yellHorn")
		await honkmation.animation_finished
		honkmation.hide()
		honkmation.pause()
		print("done")
	elif Input.is_action_just_pressed("pinkAttack"):
		honkmation.show()
		honkmation.play("pinkHorn")
		await honkmation.animation_finished
		honkmation.hide()
		honkmation.pause()
		print("done")

func _physics_process(_delta):
	handleInput()
	updateAnimation()
	move_and_slide()
	honkAbout()


func _on_ouch_box_body_entered(_body):
	$ouchBox/CollisionShape2D.set_deferred("disabled", true)
	life -= 1
	updateHealth()
	$ouchBox/Timer.start()
	print(life)
	

func _on_timer_timeout():
	$ouchBox/CollisionShape2D.set_deferred("disabled", false)
	print('time out')
