extends BTAction

export(bool) var set_target:bool = true

#----- Methods -----
func execute():
	var food_points = get_tree().get_nodes_in_group('food_point')
	var arrive_skill = tree.agent.get_node('ArriveSkill')
	var neareast_fp = null
	var neareast_d = INF
	for fp in food_points:
		var d:Vector2 = fp.get_the_position() - tree.agent.global_position
		if d.length_squared() < neareast_d:
			var database = fp.get_node('Database')
			if database.food_num <= 0:
				continue
			neareast_d = d.length_squared()
			neareast_fp = fp
	
	if neareast_fp:
		if set_target:
			arrive_skill.set_target(neareast_fp.get_the_position())
		return SUCCEEDED
	return FAILED
