extends Node

signal tick

var last_tick_timestamp:float = 0 #msec

var tick_per_frame = 1
var frame_per_sec = 60

var sec_per_tick = 1000.0 / (tick_per_frame * frame_per_sec) #msec

var listener_ticks_list = [] # {func_ref, ticks, current_ticks}

func _physics_process(delta: float) -> void:
	if get_timestamp() - last_tick_timestamp >= sec_per_tick:
		emit_signal('tick')
		last_tick_timestamp = get_timestamp()
		
		update_all_listener()
		trigger_all_listener()
	
func update_all_listener():
	var has_old = false
	for l in listener_ticks_list:
		if not l.func_ref.is_valid():
			has_old = true
	
	if has_old:
		var new_list = []
		for l in listener_ticks_list:
			if l.func_ref.is_valid():
				new_list.append(l)
		listener_ticks_list = new_list
	
func trigger_all_listener():
	for l in listener_ticks_list:
		if l.current_ticks >= l.ticks:
			l.current_ticks = 0
			l.func_ref.call_func()
		else:
			l.current_ticks += 1
	
	

func add_tick_listener(ticks_per_trigger, func_ref):
	listener_ticks_list.append({
		'func_ref': func_ref,
		'ticks': ticks_per_trigger,
		'current_ticks': 0,
	})

#----- Methods -----
func get_timestamp():
	return OS.get_ticks_msec()
