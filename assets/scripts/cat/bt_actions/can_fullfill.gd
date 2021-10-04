extends BTAction


#----- Methods -----
func execute():
	var ds = tree.agent.get_node('DesireSkill')
	var feeder = ds.get_current_feeder()
	var desire_skill = ds.get_desire_skill_by('group', feeder.get_node('FeederSkill').get_group_by_feeder_type())
	if desire_skill == null:
		return FAILED
	if feeder and desire_skill.try_interact.call_func(feeder):
		if not desire_skill.check_max_threshold.call_func():
			return SUCCEEDED
	return FAILED
