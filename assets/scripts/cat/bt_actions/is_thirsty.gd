extends BTAction


#----- Methods -----
func execute():
	var skill = tree.agent.get_node("ThirstySkill")
	if skill.is_thirsty():
		return SUCCEEDED
	return FAILED
