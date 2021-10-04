extends BTAction

export(String) var type:String
export(bool) var hide:bool = false

#----- Methods -----
func execute():
	var miao_skill = tree.agent.get_node('MiaoSkill')
	if hide:
		miao_skill.hide_msg()
	else:
		miao_skill.show_msg(type)
	return SUCCEEDED
