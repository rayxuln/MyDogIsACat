extends BTAction

export(String) var s:String

#----- Methods -----
func execute():
	var miao_skill = tree.agent.get_node('MiaoSkill')
	miao_skill.make_miao(s)
	return SUCCEEDED
