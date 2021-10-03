extends Node

class_name StateHandler

func SM():
	return get_parent()

# override
func exit_state(state:int):
	pass

# override
func enter_state(state:int):
	pass

# override
func update_state(state:int, delta:float):
	pass
