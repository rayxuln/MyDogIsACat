extends BaseSkillManager

export(NodePath) var body_area_np

var eat_cd:float = 0.5 #sec

#----- Overrides -----
func get_denpendencies():
	return [
		'MovementSkill',
		'Database',
		'HungerSkill',
		]
	
#----- Methods -----
func get_area() -> Area2D:
	var res:Area2D = get_node(body_area_np)
	return res


func get_food_point():
	for a in get_area().get_overlapping_areas():
		if a.owner.is_in_group('food_point'):
			return a.owner
	return null

func eat(food_point):
	if not $CDTimer.value:
		return false
	$CDTimer.reset(eat_cd)
	var fp = food_point.get_node('FeederSkill')
	var db = food_point.get_node('Database')
	var has_eaten = fp.consume(1)
	if has_eaten[0]:
		skills.HungerSkill.add_hunger(db.val)
	return has_eaten[0]

func try_eat(food_point):
	if skills.Database.hunger >= skills.Database.max_hunger:
		return false
	if not food_point:
		return false
	var fp = food_point.get_node('FeederSkill')
	return not fp.empty()


