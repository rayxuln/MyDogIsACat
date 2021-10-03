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
	var fp = food_point.get_node('FoodGenerateSkill')
	var has_eaten = fp.consume_food()
	if has_eaten:
		skills.HungerSkill.add_hunger(fp.food_val)
	return has_eaten

func try_eat(food_point):
	if skills.Database.hunger >= skills.Database.max_hunger:
		return false
	if not food_point:
		return false
	var fp = food_point.get_node('FoodGenerateSkill')
	return fp.try_consume_food()


