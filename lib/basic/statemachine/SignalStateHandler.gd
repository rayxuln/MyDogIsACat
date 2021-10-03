extends StateHandler
class_name SignalStateHandler

var obj:Object = null
var signalName:String = ''
var exitState

var restore_state:bool = false

#----- Methods -----
# override
func exit_state(state:int):
	obj.disconnect(signalName, self, '_on_signal')

# override
func enter_state(state:int):
	obj.connect(signalName, self, '_on_signal', [SM().current_state])

# override
func update_state(state:int, delta:float):
	if restore_state:
		SM().change_state(exitState)

#----- Signals -----
func _on_signal(currentState):
	if not SM().is_state(currentState):
		return
	if not SM().enable:
		restore_state = true
		return
	SM().change_state(exitState)
