extends BaseSkillManager 

export(int) var max_water_num = 100
export(float) var water_val:float = 1

export(NodePath) var num_label_np
export(NodePath) var cd_label_np
export(NodePath) var anim_player_np

func _ready() -> void:
	$GenerateTimer.start(next_generate_cd())
	
	skills.Database.watch('water_num', self, 'on_water_num_changed')
	skills.Database.water_num = max_water_num - randi()%60
	
	water_val = rand_range(1, 1.5)
	

func _process(delta: float) -> void:
	get_cd_label().text = '下次投放: %ds' % $GenerateTimer.time_left
#----- Overrides -----
func get_denpendencies():
	return [
		'Database'
	]
#----- Methods -----
func get_num_label():
	return get_node(num_label_np)
func get_cd_label():
	return get_node(cd_label_np)
func next_generate_cd():
	return rand_range(6, 10)

func generate_water():
	skills.Database.water_num += rand_range(10, 20)
	if skills.Database.water_num >= max_water_num:
		skills.Database.water_num = max_water_num
	else:
		water_val = rand_range(1, 1.5)
		get_node(anim_player_np).play('renew')

func consume_water(v):
	if skills.Database.water_num <= 0:
		return [false, 0]
	var water_drunck_v = min(skills.Database.water_num, v)
	skills.Database.water_num -= water_drunck_v
	get_node(anim_player_np).play('eat')
	return [true, water_drunck_v]

func try_consume_water():
	if skills.Database.water_num <= 0:
		return false
	return true
#----- Signals -----
func on_water_num_changed(new, old):
	$GenerateTimer.paused = new >= max_water_num
	get_num_label().text = '水量: %s/%s' % [new, max_water_num]

func _on_GenerateTimer_timeout() -> void:
	generate_water()
	$GenerateTimer.start(next_generate_cd())
