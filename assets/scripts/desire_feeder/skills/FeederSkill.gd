extends BaseSkillManager 


var type_groups = [
	'food_feeder',
	'water_feeder',
	'poop_handler',
]

export(NodePath) var anim_player_np
export(String, 'Food', 'Water', 'Poop') var feeder_type:String = 'Food'

var check_empty:FuncRef = null

func _ready() -> void:
	update_group_by_type()
	
#----- Overrides -----
func get_denpendencies():
	return [
		'Database',
		'PoopHandleSkill',
	]
#----- Methods -----
func get_group_by_feeder_type():
	match feeder_type:
		'Food':
			return 'food_feeder'
		'Water':
			return 'water_feeder'
		'Poop':
			return 'poop_handler'

func get_check_empty_func_by_feeder_type():
	match feeder_type:
		'Food':
			return funcref(self, 'empty')
		'Water':
			return funcref(self, 'empty')
		'Poop':
			return funcref(skills.PoopHandleSkill, 'full')

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
	return skills.Database.num <= 0



