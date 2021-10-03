extends Node

class_name SimpleStateMachine

signal enter_state(state)
signal exit_state(state)
signal update_state(state, delta)
signal state_change(new_state, old_state)
signal state_change_1arg(state)


var init_state:String = ''

export(bool) var enable:bool = true

var current_state:int = -1
var state_map:Dictionary = {}
var id_map:Dictionary = {}
var state_id_count:int = 0

func _ready() -> void:
	connect('state_change', self, '__on_state_changed')
	
	yield(get_parent(), "ready")
	if init_state.empty():
		printerr('Init state is empty.')
	if has_state(init_state):
		change_state(init_state)

func _process(delta: float) -> void:
	_update_state(current_state, delta)
#----- Methods -----
func add_state(state:String, handler:StateHandler = null):
	if not state_map.has(state):
		if handler == null:
			handler = StateHandlerFactory.create_default_state_handler()
		add_child(handler)
		state_map[state] = state_id_count
		id_map[state_map[state]] = {
			"name": state,
			"handler": handler
		}
		state_id_count += 1

func reset():
	change_state(init_state)

func SID(s:String):
	if not state_map.has(s):
		printerr('State ' + s + ' not found!')
		return -1
	return state_map[s]

func IDS(s:int):
	if not id_map.has(s):
		printerr('State id ' + str(s) + ' not found!')
		return ''
	return id_map[s].name

func get_handler(s):
	var id = toSID(s)
	if id == -1:
		return null
	return id_map[id].handler

func toSID(s):
	if s is String:
		return SID(s)
	assert(s is int)
	return s

func has_state(s):
	s = toSID(s)
	return id_map.has(s)

func change_state(new_state):
	new_state = toSID(new_state)
	_exit_state(current_state)
	var old_state = current_state
	current_state = new_state
	_enter_state(current_state)
	emit_signal("state_change", current_state, old_state)

func _enter_state(s):
	if not enable:
		return
	if has_state(s):
		if id_map[s].handler:
			id_map[s].handler.enter_state(s)
		enter_state(s)
		emit_signal("enter_state", s)

func _update_state(s, delta):
	if not enable:
		return
	if has_state(s):
		if id_map[s].handler:
			id_map[s].handler.update_state(s, delta)
		update_state(s, delta)
		emit_signal("update_state", s, delta)

func _exit_state(s):
	if not enable:
		return
	if has_state(s):
		if id_map[s].handler:
			id_map[s].handler.exit_state(s)
		exit_state(s)
		emit_signal("exit_state", s)

func is_state(s):
	s = toSID(s)
	return s == current_state

# override
func enter_state(state:int):
	pass

# override
func update_state(state:int, delta:float):
	pass

# override
func exit_state(state:int):
	pass

#----- Signals -----
func __on_state_changed(newState, oldState):
	emit_signal("state_change_1arg", IDS(newState))
