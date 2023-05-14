extends Area2D
signal attentive



func _ready():
	area_entered.connect(AreaEnt)


func AreaEnt(area):
	if area == Global.enInteraction:
		emit_signal("attentive")
		print("I see you bitch")
		
func _process(_delta):
	pass
