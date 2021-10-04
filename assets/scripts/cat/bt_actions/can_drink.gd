extends BTAction


#----- Methods -----
func execute():
	var drink_skill = tree.agent.get_node('DrinkSkill')
	var water_point = drink_skill.get_water_point()
	if water_point and drink_skill.try_drink(water_point):
		if not drink_skill.is_rich_the_max_threshold():
			return SUCCEEDED
	return FAILED
