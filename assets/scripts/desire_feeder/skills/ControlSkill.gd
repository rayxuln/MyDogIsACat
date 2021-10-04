extends BaseSkillManager 

export(float) var add_val = 1

#----- Overrides -----
func get_denpendencies():
	return [
		'Database',
		'GenerateSkill',
	]
#----- Methods -----

#----- Signals -----
func _on_AddButton_pressed() -> void:
	skills.Database.num += add_val
	if skills.Database.num > skills.GenerateSkill.max_num:
		skills.Database.num = skills.GenerateSkill.max_num

func _on_Empty_pressed() -> void:
	skills.Database.num = 0

func _on_SubButton_pressed() -> void:
	skills.Database.num -= add_val
	if skills.Database.num < 0:
		skills.Database.num = 0
