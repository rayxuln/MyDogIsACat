extends RichTextLabel


var status:Dictionary = {}

var temp_msg_list:Array = []

const msg_exist_time:float = 3000.0 #msec


func _process(delta: float) -> void:
	var has_old_msg = false
	for msg in temp_msg_list:
		if OS.get_ticks_msec() - msg.timestamp >= msg_exist_time:
			has_old_msg = true
			break
	
	if has_old_msg:
		var new_msg_list = []
		for msg in temp_msg_list:
			if OS.get_ticks_msec() - msg.timestamp < msg_exist_time:
				new_msg_list.append(msg)
		temp_msg_list = new_msg_list
		
		update_text()
	
	
#----- Methods -----
func update_text():
	var s = ""
	var cnt = 0
	for k in status.keys():
		var v = str(status[k])
		s += "%s: %s" % [k, v]
		if cnt < status.keys().size() - 1:
			s += "\n"
		cnt += 1
	
	if not s.empty() and not temp_msg_list.empty():
		s += "\n[color=green]>=====| Temp Messages |=====<\n[/color]"
	
	cnt = 0
	for msg in temp_msg_list:
		if msg.from != null:
			s += "[%s]: %s" % [msg.from, msg.msg]
		else:
			s += msg.msg
		if cnt < temp_msg_list.size() - 1:
			s += "\n"
		cnt += 1
	
	bbcode_text = s

func set_status(k, v):
	status[k] = v
	update_text()

func add_msg(msg, from = null):
	temp_msg_list.append({
		"from": from,
		"msg": str(msg),
		"timestamp": OS.get_ticks_msec(),
	})
	update_text()



