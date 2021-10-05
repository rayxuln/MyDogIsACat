extends BTAction

func start():
	.start()
	var ds = tree.agent.get_node('DesireSkill')
	var feeder = ds.get_current_feeder()
	var group = feeder.get_node('FeederSkill').get_group_by_feeder_type()
	var desire_skill = ds.get_desire_skill_by('group', group)
	if desire_skill and group == 'poop_handler':
		desire_skill.obj.poop_start()

func end():
	.end()
	var ds = tree.agent.get_node('DesireSkill')
	var feeder = ds.get_current_feeder()
	var group = feeder.get_node('FeederSkill').get_group_by_feeder_type()
	var desire_skill = ds.get_desire_skill_by('group', group)
	if desire_skill and group == 'poop_handler':
		desire_skill.obj.poop_end()

#----- Methods -----
func execute():
	var ds = tree.agent.get_node('DesireSkill')
	var feeder = ds.get_current_feeder()
	var desire_skill = ds.get_desire_skill_by('group', feeder.get_node('FeederSkill').get_group_by_feeder_type())
	if desire_skill == null:
		return FAILED
	if feeder and desire_skill.interact.call_func(feeder):
		return SUCCEEDED
	return RUNNING
