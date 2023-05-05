extends Area2D
@onready var honkboxx = $honkBox
@onready var honkmation = $honkimation
func _ready():
	Global.interaction = self
	
func honkAbout():
	if Input.is_action_just_pressed("pinkAttack"):
		honkboxx.set_deferred("disabled", false)
		honkmation.show()
		honkmation.play("pinkHonk")
		await honkmation.animation_finished
		honkboxx.set_deferred("disabled", true)
		honkmation.hide()
		honkmation.pause()
		print("done")
	elif Input.is_action_just_pressed("blueAttack"):
		honkboxx.set_deferred("disabled", false)
		honkmation.show()
		honkmation.play("blueHonk")
		await honkmation.animation_finished
		honkboxx.set_deferred("disabled", true)
		honkmation.hide()
		honkmation.pause()
		print("done")
	elif Input.is_action_just_pressed("yellAttack"):
		honkboxx.set_deferred("disabled", false)
		honkmation.show()
		honkmation.play("yellowHonk")
		await honkmation.animation_finished
		honkboxx.set_deferred("disabled", true)
		honkmation.hide()
		honkmation.pause()
		print("done")

