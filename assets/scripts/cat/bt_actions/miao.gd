extends BTAction

export(String) var type:String

#----- Methods -----
func execute():
	var miao_skill = tree.agent.get_node('MiaoSkill')
	miao_skill.make_miao(type)
	return SUCCEEDED
