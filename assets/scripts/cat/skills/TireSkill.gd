extends BaseSkillManager


func _ready() -> void:
	TickSystem.connect('tick', self, 'on_ticked')

#----- Overrides -----
func get_denpendencies():
	return [
		'Database'
	]
	
#----- Methods -----
func update_tire():
	if randf() <= skills.Database.tire_rate:
		skills.Database.tire += 0.1
		if skills.Database.tire > skills.Database.max_tire:
			skills.Database.tire = skills.Database.max_tire
	
func change_rate_to_fast():
	skills.Database.tire_rate = 0.3

func change_rate_to_slow():
	skills.Database.tire_rate = 0.2
#----- Signals -----
func on_ticked():
	update_tire()
	

