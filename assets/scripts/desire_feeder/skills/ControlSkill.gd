extends BaseSkillManager 

export(float) var add_val = 1

export(NodePath) var cd_button_np:NodePath

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

func _on_Cd_pressed() -> void:
	skills.GenerateSkill.cd_paused = !skills.GenerateSkill.cd_paused
	if skills.GenerateSkill.cd_paused:
		get_node(cd_button_np).text = '||'
	else:
		get_node(cd_button_np).text = '>'
