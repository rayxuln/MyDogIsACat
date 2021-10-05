extends BTAction

export(bool) var set_target:bool = true

#----- Methods -----
func execute():
	var desire_skill = tree.agent.get_node('DesireSkill').get_desire_skill()
	if desire_skill == null:
		return SUCCEEDED
	
	var desire_feeders = get_tree().get_nodes_in_group(desire_skill.group)
	var arrive_skill = tree.agent.get_node('ArriveSkill')
	var neareast_df = null
	var neareast_d = INF
	for df in desire_feeders:
		var d:Vector2 = df.get_the_position() - tree.agent.global_position
		if d.length_squared() < neareast_d:
			var fs = df.get_node('FeederSkill')
			if fs.get_check_empty_func_by_feeder_type().call_func():
				continue
			neareast_d = d.length_squared()
			neareast_df = df
	
	if neareast_df:
		if set_target:
			arrive_skill.set_target(neareast_df.get_the_position())
		return SUCCEEDED
	return FAILED
