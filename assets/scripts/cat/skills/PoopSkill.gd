extends BaseSkillManager


func _ready() -> void:
	skills.Database.watch('hunger', self, 'on_hunger_changed')
	skills.Database.watch('thirsty', self, 'on_thirsty_changed')

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
	
#----- Signals -----
func on_hunger_changed(new, old):
	update_poop(old - new)

func on_thirsty_changed(new, old):
	update_poop(old - new)
	

