extends BTAction


#----- Methods -----
func execute():
	var eat_skill = tree.agent.get_node('EatSkill')
	var food_point = eat_skill.get_food_point()
	if food_point and eat_skill.eat(food_point):
		return SUCCEEDED
	return RUNNING
