extends BaseSkillManager

export(float) var cd:float = 1

#----- Overrides -----
func get_denpendencies():
	return [
		]
	
#----- Methods -----
func make_miao(s):
	if not $CD.value:
		return
	$CD.reset(cd)
	var m = preload('res://assets/prefabs/MiaoEffect.tscn').instance()
	CommonHelper.game_manager.get_world().add_child(m)
	m.global_position = owner.global_position
	m.init(s)
