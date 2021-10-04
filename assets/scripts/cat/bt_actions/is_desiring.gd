extends BTAction


#----- Methods -----
func execute():
	var desire_skill = tree.agent.get_node("DesireSkill").get_desire_skill()
	if desire_skill:
		return SUCCEEDED
	return FAILED
