extends Reference

class_name InputState

var pressed:bool = false
var last_pressed:bool = false
var just_pressed:bool = false
var just_released:bool = false

var strength:float = 0
var dead_zone:float = 0.1

#----- Methods -----
func set_pressed(b):
	pressed = b
	strength = 1 if b else 0

func set_strength(s):
	pressed = true if s >= dead_zone else false
	strength = s if s >= dead_zone else 0

func update():
	just_pressed = pressed and pressed != last_pressed
	just_released = not pressed and pressed != last_pressed
	last_pressed = pressed



