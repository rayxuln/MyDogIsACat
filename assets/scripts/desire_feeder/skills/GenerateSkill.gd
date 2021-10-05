extends BaseSkillManager 

export(String) var num_text:String = "%s/%s"
export(String) var renew_text:String = "下次投放: %ds"

export(int) var max_num = 100
export(float) var init_num = 60

export(float) var min_val:float = 1
export(float) var max_val:float = 1.5

export(float) var regenerate_min_num = 10
export(float) var regenerate_max_num = 20

export(NodePath) var num_label_np
export(NodePath) var cd_label_np
export(NodePath) var anim_player_np

export(bool) var cd_paused = false

func _ready() -> void:
	$GenerateTimer.start(next_generate_cd())
	
	skills.Database.watch('num', self, 'on_num_changed')
	skills.Database.num = init_num
	
	skills.Database.val = rand_range(min_val, max_val)

func _process(delta: float) -> void:
	get_cd_label().text = renew_text % $GenerateTimer.time_left
	$GenerateTimer.paused = (skills.Database.num >= max_num if sign(regenerate_min_num) > 0 else skills.Database.num <= 0) or cd_paused
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

func generate():
	var old = skills.Database.num
	skills.Database.num += rand_range(regenerate_min_num, regenerate_max_num)
	
	skills.Database.num = clamp(skills.Database.num, 0, max_num)
	
	if skills.Database.num != old:
		skills.Database.val = rand_range(min_val, max_val)
		get_node(anim_player_np).play('renew')

#----- Signals -----
func on_num_changed(new, old):
	get_num_label().text = num_text % [new, max_num]

func _on_GenerateTimer_timeout() -> void:
	generate()
	$GenerateTimer.start(next_generate_cd())
