extends BaseSkillManager

export(float) var cd:float = 1
export(float) var msg_show_time:float = 5

export(NodePath) var miao_msg_np

#----- Overrides -----
func get_denpendencies():
	return [
		'DesireSkill'
		]
	
#----- Methods -----
func make_string_miao(s):
	if not $CD.value:
		return
	$CD.reset(cd)
	var m = preload('res://assets/prefabs/MiaoEffect.tscn').instance()
	CommonHelper.game_manager.get_world().add_child(m)
	m.global_position = owner.global_position
	m.init(s)
	
	hide_msg()

func show_string_msg(s):
	var msg = get_node(miao_msg_np)
	msg.visible = true
	msg.get_node('TextLabel').text = s
	$MsgShowTimer.start(msg_show_time)

func make_miao(type):
	match type:
		'FeederIsEmpty':
			var ds = skills.DesireSkill.get_desire_skill()
			if ds != null:
				make_string_miao(ds.obj.feeder_empty_string)

func show_msg(type):
	match type:
		'GoToFeeder':
			var ds = skills.DesireSkill.get_desire_skill()
			if ds != null:
				show_string_msg(ds.obj.go_to_feeder_string)

func hide_msg():
	get_node(miao_msg_np).visible = false
	$MsgShowTimer.stop()
#----- Signals -----
func _on_MsgShowTimer_timeout() -> void:
	get_node(miao_msg_np).visible = false


