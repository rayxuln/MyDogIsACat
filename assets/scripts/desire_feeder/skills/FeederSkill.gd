extends BaseSkillManager 


var type_groups = [
	'food_feeder',
	'water_feeder',
]

export(NodePath) var anim_player_np
export(String, 'Food', 'Water') var feeder_type:String = 'Food'


func _ready() -> void:
	update_group_by_type()
#----- Overrides -----
func get_denpendencies():
	return [
		'Database'
	]
#----- Methods -----
func get_group_by_feeder_type():
	match feeder_type:
		'Food':
			return 'food_feeder'
		'Water':
			return 'water_feeder'
	
func update_group_by_type():
	for g in type_groups:
		if owner.is_in_group(g):
			owner.remove_from_group(g)
	
	owner.add_to_group(get_group_by_feeder_type())

func consume(v):
	if skills.Database.num <= 0:
		return [false, 0]
	var consumed_v = min(skills.Database.num, v)
	skills.Database.num -= consumed_v
	get_node(anim_player_np).play('eat')
	return [true, consumed_v]

func empty():
	if skills.Database.num <= 0:
		return true
	return false



