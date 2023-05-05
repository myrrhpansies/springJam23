extends Area2D
signal Change
signal Back
@onready var horn = Global.interaction


func _ready():
	area_entered.connect(AreaEnt)
	area_exited.connect(AreaEx)

func AreaEnt(area):
	if area == horn:
		emit_signal("Change")
		print("yay!")
		
func AreaEx(area):
	if area == horn:
		emit_signal("Back")
		print("boo")		
		
func _process(_delta):
	pass
