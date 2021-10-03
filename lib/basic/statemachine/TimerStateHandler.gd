extends StateHandler
class_name TimerStateHandler

var wait:float = 0 #sec
var exitState

var time:float = 0

#----- Methods -----
# override
func exit_state(state:int):
	pass

# override
func enter_state(state:int):
	time = OS.get_ticks_msec()

# override
func update_state(state:int, delta:float):
	if OS.get_ticks_msec() - time >= wait * 1000:
		SM().change_state(exitState)
