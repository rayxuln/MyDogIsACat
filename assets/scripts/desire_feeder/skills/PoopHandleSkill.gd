extends BaseSkillManager 


export(NodePath) var anim_player_np

#----- Overrides -----
func get_denpendencies():
	return [
		'Database',
		'GenerateSkill',
	]
#----- Methods -----
func put_poop(v):
	v = min(skills.GenerateSkill.max_num - skills.Database.num, v)
	if v == 0:
		return [false, 0]
	skills.Database.num += v
	get_node(anim_player_np).play('eat')
	return [true, v]

func full():
	return skills.Database.num >= skills.GenerateSkill.max_num
