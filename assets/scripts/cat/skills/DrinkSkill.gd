extends BaseSkillManager

export(NodePath) var body_area_np
export(float) var drink_val:float = 10

var drink_cd:float = 0.5 #sec

#----- Overrides -----
func get_denpendencies():
	return [
		'MovementSkill',
		'Database',
		'ThirstySkill',
		]
	
#----- Methods -----
func get_area() -> Area2D:
	var res:Area2D = get_node(body_area_np)
	return res


func get_water_point():
	for a in get_area().get_overlapping_areas():
		if a.owner.is_in_group('water_point'):
			return a.owner
	return null

func drink(water_point):
	if not $CDTimer.value:
		return false
	$CDTimer.reset(drink_cd)
	var wp = water_point.get_node('FeederSkill')
	var db = water_point.get_node('Database')
	var v = drink_val + rand_range(-5, 5)
	var has_drunck = wp.consume(v)
	if has_drunck[0]:
		skills.ThirstySkill.add_thirsty(db.val * has_drunck[1])
	return has_drunck[0]

func is_rich_the_max_threshold():
	return skills.Database.thirsty >= skills.Database.thirsty_max_threshold

func try_drink(water_point):
	if skills.Database.thirsty >= skills.Database.max_thirsty:
		return false
	if not water_point:
		return false
	var wp = water_point.get_node('FeederSkill')
	return not wp.empty()


