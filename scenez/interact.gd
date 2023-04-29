extends Area2D
class_name Actionable
signal Change
signal Back


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(AreaEnt)
	body_exited.connect(AreaEx)

func AreaEnt(body):
	if body.name == "sprout":
		emit_signal("Change")
		print("yay!")
		
func AreaEx(body):
	if body.name == "sprout":
		emit_signal("Back")
		print("boo")		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
