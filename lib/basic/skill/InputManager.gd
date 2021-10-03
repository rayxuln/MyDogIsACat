extends Node
class_name InputManager

export(Array, String) var states:Array = []

var input_state_list:Dictionary = {}

func _ready() -> void:
	create_input_state_list()

func _process(delta: float) -> void:
	update_all_input_state()
	
#----- Methods -----
func create_input_state_list():
	for s in states:
		add_input_state(s)

func update_all_input_state():
	for k in input_state_list.keys():
		input_state_list[k].update()

func add_input_state(k):
	input_state_list[k] = InputState.new()
	
func set_input_state_pressed(k, p):
	input_state_list[k].set_pressed(p)

func set_input_state_strength(k, s):
	input_state_list[k].set_strength(s)

func get_strength(k):
	return input_state_list[k].strength

func is_just_pressed(k):
	return input_state_list[k].just_pressed

func is_just_released(k):
	return input_state_list[k].just_released

func is_pressed(k):
	return input_state_list[k].pressed

func is_released(k):
	return not input_state_list[k].pressed
