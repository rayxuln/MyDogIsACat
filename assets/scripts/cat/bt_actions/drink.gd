extends BTAction


#----- Methods -----
func execute():
	var drink_skill = tree.agent.get_node('DrinkSkill')
	var water_point = drink_skill.get_water_point()
	if water_point and drink_skill.drink(water_point):
		return SUCCEEDED
	return RUNNING
