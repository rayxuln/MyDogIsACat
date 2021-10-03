extends BaseSkillManager 

export(int) var max_food_num = 10
export(float) var food_val:float = 10

export(NodePath) var num_label_np
export(NodePath) var cd_label_np
export(NodePath) var anim_player_np

func _ready() -> void:
	$GenerateTimer.start(next_generate_cd())
	
	skills.Database.watch('food_num', self, 'on_food_num_changed')
	skills.Database.food_num = min(max_food_num, randi()%3+3)
	
	food_val = rand_range(10, 20)
	

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

func generate_food():
	skills.Database.food_num += 1
	if skills.Database.food_num >= max_food_num:
		skills.Database.food_num = max_food_num
	else:
		food_val = rand_range(10, 20)
		get_node(anim_player_np).play('renew')

func consume_food():
	if skills.Database.food_num <= 0:
		return false
	skills.Database.food_num -= 1
	get_node(anim_player_np).play('eat')
	return true

func try_consume_food():
	if skills.Database.food_num <= 0:
		return false
	return true
#----- Signals -----
func on_food_num_changed(new, old):
	$GenerateTimer.paused = new >= max_food_num
	get_num_label().text = '食物: %s' % new

func _on_GenerateTimer_timeout() -> void:
	generate_food()
	$GenerateTimer.start(next_generate_cd())
