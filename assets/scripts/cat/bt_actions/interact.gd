extends BTAction

var current_disire_skill = null

func start():
	.start()
	var ds = tree.agent.get_node('DesireSkill')
	var feeder = ds.get_current_feeder()
	if feeder == null:
		current_disire_skill = null
		return
	var group = feeder.get_node('FeederSkill').get_group_by_feeder_type()
	current_disire_skill = ds.get_desire_skill_by('group', group)
	if current_disire_skill and group == 'poop_handler':
		current_disire_skill.obj.poop_start()

func end():
	.end()
	if current_disire_skill == null:
		return
	if current_disire_skill.group == 'poop_handler':
		current_disire_skill.obj.poop_end()

#----- Methods -----
func execute():
	var ds = tree.agent.get_node('DesireSkill')
	var feeder = ds.get_current_feeder()
	if current_disire_skill == null:
		return FAILED
	if feeder == null:
		return FAILED
	var res = current_disire_skill.interact.call_func(feeder)
	if res[1]: # 是否成功
		return SUCCEEDED
	if res[0]: # 是否正在进行
		return RUNNING
	return FAILED
