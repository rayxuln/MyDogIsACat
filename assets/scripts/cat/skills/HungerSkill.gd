extends BaseSkillManager


func _ready() -> void:
	TickSystem.connect('tick', self, 'on_ticked')

#----- Overrides -----
func get_denpendencies():
	return [
		'Database'
	]
	
#----- Methods -----
func update_hunger():
	if randf() <= skills.Database.hunger_rate:
		skills.Database.hunger -= 0.1
		if skills.Database.hunger < 0:
			skills.Database.hunger = 0
	
func change_rate_to_fast():
	skills.Database.hunger_rate = 0.5

func change_rate_to_slow():
	skills.Database.hunger_rate = 0.1

func add_hunger(v):
	skills.Database.hunger += v
	if skills.Database.hunger > skills.Database.max_hunger:
		skills.Database.hunger = skills.Database.max_hunger

func is_hungery():
	return skills.Database.hunger <= skills.Database.hunger_threshold
#----- Signals -----
func on_ticked():
	update_hunger()
	

