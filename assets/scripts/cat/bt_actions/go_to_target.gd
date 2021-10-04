extends BTAction

#----- Methods -----
func execute():
	var arrive_skill = tree.agent.get_node("ArriveSkill")
	if arrive_skill.is_arrived:
		return SUCCEEDED
	return RUNNING

func start():
	.start()
	var arrive_skill = tree.agent.get_node("ArriveSkill")
	arrive_skill.go_to(null)

func end():
	.end()
	var arrive_skill = tree.agent.get_node("ArriveSkill")
	arrive_skill.stop()
