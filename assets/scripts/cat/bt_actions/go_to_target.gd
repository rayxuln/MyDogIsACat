extends BTAction

#----- Methods -----
func execute():
	var arrive_skill = tree.agent.get_node("ArriveSkill")
	if arrive_skill.is_arrived:
		return SUCCEEDED
	return RUNNING
