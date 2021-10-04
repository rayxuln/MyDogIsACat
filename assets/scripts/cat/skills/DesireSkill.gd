extends BaseSkillManager


export(NodePath) var body_area_np


var desire_skill_list = []

func _ready() -> void:
	add_desire_skill(
		'food_feeder',
		skills.HungerSkill, 'is_hungery', 'add_hungery', 'has_reach_max_threshold',
		skills.EatSkill, 'eat', 'try_eat'
		)
	add_desire_skill(
		'water_feeder',
		skills.ThirstySkill, 'is_thirsty', 'add_thirsty', 'has_reach_max_threshold',
		skills.DrinkSkill, 'drink', 'try_drink'
		)
#----- Overrides -----
func get_denpendencies():
	return [
		'Database',
		'HungerSkill',
		'ThirstySkill',
		'EatSkill',
		'DrinkSkill',
	]
#----- Methods -----
func add_desire_skill(
	group,
	obj, check_func_name, add_func_name, max_threshold_func_name,
	interact_obj, interact_func_name, try_interact_func_name
	):
	desire_skill_list.append({
		'group': group,
		'obj': obj,
		'check': funcref(obj, check_func_name),
		'check_max_threshold': funcref(obj, max_threshold_func_name),
		'add': funcref(obj, add_func_name),
		'interact_obj': interact_obj,
		'interact': funcref(interact_obj, interact_func_name),
		'try_interact': funcref(interact_obj, try_interact_func_name),
	})

func get_desire_skill():
	for d in desire_skill_list:
		if d.check.call_func():
			return d
	return null

func get_desire_skills():
	var res = []
	for d in desire_skill_list:
		if d.check.call_func():
			res.append(d)
	return res

func get_current_feeder():
	for a in get_node(body_area_np).get_overlapping_areas():
		if a.owner.is_in_group('desire_feeder'):
			return a.owner
	return null

func get_desire_skill_by(k, v):
	for ds in desire_skill_list:
		if ds[k] == v:
			return ds
	return null
