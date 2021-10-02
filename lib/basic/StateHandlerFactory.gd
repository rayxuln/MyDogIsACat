extends Object
class_name StateHandlerFactory


static func create_signal_state_handler(obj, signalName, exitState) -> SignalStateHandler:
	var s = SignalStateHandler.new()
	s.obj = obj
	s.signalName = signalName
	s.exitState = exitState
	return s

static func create_timer_state_handler(exitState, wait:float = 1) -> TimerStateHandler:
	var s = TimerStateHandler.new()
	s.exitState = exitState
	s.wait = wait
	return s

static func create_default_state_handler(debug:bool = false) -> DefaultStateHandler:
	var s = DefaultStateHandler.new()
	s.debug = debug
	return s
