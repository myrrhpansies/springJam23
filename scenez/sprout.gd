extends CharacterBody2D
signal healthChanged

@export var Speed: int = 300
@onready var life: int = 5
@onready var animations = $Sprite2D/AnimationPlayer
@onready var honkmation = $honkDetector/AnimatedSprite2D
var canMove = true
var canHonk = true
var canDash = true


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
	if Input.is_action_just_pressed("left") and canMove:
		animations.play("base")
		scale.y = 1
		rotation_degrees = 0
	elif Input.is_action_just_pressed("right") and canMove:
		animations.play("base")
		scale.y = -1
		rotation_degrees = 180
	if canMove:
		if Input.is_action_just_pressed("blueAttack") or Input.is_action_just_pressed("pinkAttack") or  Input.is_action_just_pressed("baseAttack") or Input.is_action_just_pressed("yellAttack"):
			canMove = false
			animations.play("attack")
			await animations.animation_finished
			animations.play("base")
			canMove = true
		elif Input.is_action_just_pressed("dash") and canDash:
			
			canMove = false
			canDash = false
			$dashTimer.start()
			$ghostTimer.start()
			Speed *= 3
		else: 
			pass
	
func honkAbout():
	if canHonk:
		if Input.is_action_just_pressed("blueAttack"):
			canHonk = false
			honkmation.show()
			honkmation.play("blueHorn")
			await honkmation.animation_finished
			honkmation.hide()
			honkmation.pause()
			canHonk = true
		elif Input.is_action_just_pressed("yellAttack"):
			canHonk = false
			honkmation.show()
			honkmation.play("yellHorn")
			await honkmation.animation_finished
			honkmation.hide()
			honkmation.pause()
			canHonk = true
		elif Input.is_action_just_pressed("pinkAttack"):
			canHonk = false
			honkmation.show()
			honkmation.play("pinkHorn")
			await honkmation.animation_finished
			honkmation.hide()
			honkmation.pause()
			canHonk = true
		elif Input.is_action_just_pressed("baseAttack"):
			canHonk = false
			honkmation.show()
			honkmation.play("whiteHonk")
			await honkmation.animation_finished
			honkmation.hide()
			honkmation.pause()
			canHonk = true	

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
	emit_signal("healthChanged")
	

func _on_timer_timeout():
	$ouchBox/CollisionShape2D.set_deferred("disabled", false)


func _on_dash_timer_timeout():
	canMove = true
	Speed /= 3
	$dashSpacer.start()
	
	


func _on_dash_spacer_timeout():
	canDash = true


func _on_ghost_timer_timeout():
	pass


