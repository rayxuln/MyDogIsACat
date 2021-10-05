extends BaseSkillManager

export(String) var go_to_feeder_string = "去拉便便..."
export(String) var feeder_empty_string = "嘿，没地方拉便便啦!"

export(NodePath) var progress_bar_np:NodePath
export(float) var poop_time:float = 5 #sec

export(float) var poop_min_val:float = 40
export(float) var poop_max_val:float = 60

func _ready() -> void:
	skills.Database.watch('hunger', self, 'on_hunger_changed')
	skills.Database.watch('thirsty', self, 'on_thirsty_changed')

func _process(delta: float) -> void:
	if not $PoopTimer.is_stopped():
		var pb:ProgressBar = get_node(progress_bar_np)
		pb.value = 100 - $PoopTimer.time_left / $PoopTimer.wait_time * 100
#----- Overrides -----
func get_denpendencies():
	return [
		'Database'
	]
	
#----- Methods -----
func update_poop(v):
	if v <= 0:
		return
	skills.Database.poop += v * skills.Database.poop_rate
	if skills.Database.poop >= skills.Database.max_poop:
		skills.Database.poop = skills.Database.max_poop
	

func poop_start():
	$PoopTimer.start(poop_time)
	var pb:ProgressBar = get_node(progress_bar_np)
	pb.visible = true
	pb.value = 100
	pb.max_value = 100

func poop_end():
	$PoopTimer.stop()
	var pb:ProgressBar = get_node(progress_bar_np)
	pb.visible = false

func decrease_poop(v):
	skills.Database.poop -= v
	if skills.Database.poop < 0:
		skills.Database.poop = 0

# [正在拉, 是否成功]
func poop(poop_point):
	if not $PoopTimer.is_stopped():
		return [true, false]
	var ph = poop_point.get_node('PoopHandleSkill')
	var v = min(skills.Database.poop, rand_range(poop_min_val, poop_max_val))
	var has_pooped = ph.put_poop(v)
	if has_pooped[0]:
		decrease_poop(has_pooped[1])
	return [false, has_pooped[0]]

func try_poop(poop_point):
	if skills.Database.poop <= 0:
		return false
	if not poop_point:
		return false
	var ph = poop_point.get_node('PoopHandleSkill')
	return not ph.full()

func is_need_to_poop():
	return skills.Database.poop > skills.Database.poop_threshold

func has_reach_min_threshold():
	return skills.Database.poop <= skills.Database.poop_min_threshold
#----- Signals -----
func on_hunger_changed(new, old):
	update_poop(old - new)

func on_thirsty_changed(new, old):
	update_poop(old - new)
	

func _on_PoopTimer_timeout() -> void:
	poop_end()
