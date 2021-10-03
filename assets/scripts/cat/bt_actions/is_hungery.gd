extends BTAction


#----- Methods -----
func execute():
	var hunger_skill = tree.agent.get_node("HungerSkill")
	if hunger_skill.is_hungery():
		return SUCCEEDED
	return FAILED
