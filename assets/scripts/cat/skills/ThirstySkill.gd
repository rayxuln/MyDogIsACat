extends BaseSkillManager

export(String) var go_to_feeder_string = "喝水去咯~"
export(String) var feeder_empty_string = "嘿，没水啦!"

func _ready() -> void:
	TickSystem.connect('tick', self, 'on_ticked')

#----- Overrides -----
func get_denpendencies():
	return [
		'Database'
	]
	
#----- Methods -----
func update_thirsty():
	if randf() <= skills.Database.thirsty_rate:
		skills.Database.thirsty -= 0.1
		if skills.Database.thirsty < 0:
			skills.Database.thirsty = 0
	
func change_rate_to_fast():
	skills.Database.thirsty_rate = 0.5

func change_rate_to_slow():
	skills.Database.thirsty_rate = 0.1

func is_thirsty():
	return skills.Database.thirsty < skills.Database.thirsty_threshold

func add_thirsty(v):
	skills.Database.thirsty += v
	if skills.Database.thirsty > skills.Database.max_thirsty:
		skills.Database.thirsty = skills.Database.max_thirsty

func has_reach_max_threshold():
	return skills.Database.thirsty >= skills.Database.thirsty_max_threshold
#----- Signals -----
func on_ticked():
	update_thirsty()
	

