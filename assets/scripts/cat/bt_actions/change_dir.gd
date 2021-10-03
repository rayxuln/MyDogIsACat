extends BTAction

export(String) var dir = "random"

#----- Methods -----
func execute():
	var move_skill = tree.agent.get_node("MovementSkill")
	match dir:
		"random":
			move_skill.set_direction(Vector2.RIGHT.rotated(deg2rad(randi()%360)))
		"up":
			move_skill.set_direction(Vector2.UP)
		"down":
			move_skill.set_direction(Vector2.DOWN)
		"left":
			move_skill.set_direction(Vector2.LEFT)
		"right":
			move_skill.set_direction(Vector2.RIGHT)
	
	return SUCCEEDED
