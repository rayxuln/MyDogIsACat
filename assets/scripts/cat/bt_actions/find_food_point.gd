extends BTAction


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
			if database.food_num <= 0 and neareast_fp != null:
				continue
			neareast_d = d.length_squared()
			neareast_fp = fp
	
	if neareast_fp:
		arrive_skill.go_to(neareast_fp.get_the_position())
		return SUCCEEDED
	return FAILED
