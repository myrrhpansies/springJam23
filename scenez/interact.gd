extends Area2D
signal Change
signal Back


func _ready():
	area_entered.connect(AreaEnt)
	area_exited.connect(AreaEx)

func AreaEnt(area):
	if area == Global.interaction:
		emit_signal("Change")
		print("yay!")
		
func AreaEx(area):
	if area == Global.interaction:
		emit_signal("Back")
		print("boo")		
		
func _process(_delta):
	pass
