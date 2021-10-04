extends BTAction

export(bool) var set_target:bool = true

#----- Methods -----
func execute():
	var water_points = get_tree().get_nodes_in_group('water_point')
	var arrive_skill = tree.agent.get_node('ArriveSkill')
	var neareast_wp = null
	var neareast_d = INF
	for wp in water_points:
		var d:Vector2 = wp.get_the_position() - tree.agent.global_position
		if d.length_squared() < neareast_d:
			var database = wp.get_node('Database')
			if database.water_num <= 0:
				continue
			neareast_d = d.length_squared()
			neareast_wp = wp
	
	if neareast_wp:
		if set_target:
			arrive_skill.set_target(neareast_wp.get_the_position())
		return SUCCEEDED
	return FAILED
