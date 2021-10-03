extends BTAction

export(bool) var enable:bool

#----- Methods -----
func execute():
	var move_skill = tree.agent.get_node("MovementSkill")
	move_skill.set_move(enable)
	return SUCCEEDED
