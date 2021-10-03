extends BTAction

func start():
	.start()
	
	var arrive_skill = tree.agent.get_node("ArriveSkill")
	
	var room_rect = CommonHelper.get_room_rect()
	
	var rand_x = lerp(room_rect[0].x, room_rect[1].x, randf())
	var rand_y = lerp(room_rect[0].y, room_rect[1].y, randf())
	arrive_skill.go_to(Vector2(rand_x, rand_y))

#----- Methods -----
func execute():
	var arrive_skill = tree.agent.get_node("ArriveSkill")
	if arrive_skill.is_arrived:
		return SUCCEEDED
	return RUNNING
