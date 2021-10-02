extends StateHandler
class_name DefaultStateHandler

export(bool) var debug = false
	
# override
func exit_state(state:int):
	if debug:
		print('Exit state: ' + SM().IDS(state))

# override
func enter_state(state:int):
	if debug:
		print('Enter state: ' + SM().IDS(state))

# override
func update_state(state:int, delta:float):
	if debug:
		print('Update state: ' + SM().IDS(state))
