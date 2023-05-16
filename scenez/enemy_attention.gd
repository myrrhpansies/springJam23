extends Area2D
signal attentive
signal weak
signal notWeak

func _ready():
	area_entered.connect(AreaEnt)
	area_exited.connect(AreaExx)

func AreaEnt(area):
	if area == Global.enInteraction:
		emit_signal("attentive")
	if area == Global.interaction:
		emit_signal("weak")	

func AreaExx(area):
	if area == Global.interaction:
		emit_signal("notWeak")
		
func _process(_delta):
	pass
