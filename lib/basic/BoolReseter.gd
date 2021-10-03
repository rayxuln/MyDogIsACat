tool
extends Timer
class_name BoolReseter

var value:bool = true


func _ready() -> void:
	one_shot = true
	connect('timeout', self, '_on_timeout')


#----- Methods -----
func reset(t:float):
	value = false
	start(t)
#----- Signals -----
func _on_timeout():
	value = true
