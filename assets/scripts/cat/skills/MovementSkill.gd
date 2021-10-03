extends BaseSkillManager

export(float) var move_speed:float = 5

var move_dir:Vector2 = Vector2.RIGHT
var move_enable:bool = false

func _physics_process(delta: float) -> void:
	if move_enable:
		var b:KinematicBody2D = get_owner()
		b.move_and_slide(move_dir * move_speed * delta * 1000)
	

#----- Overrides -----
func get_denpendencies():
	return [
		'HungerSkill',
		'ThirstySkill',
		'TireSkill',
	]
	
#----- Methods -----
func set_move(enable:bool):
	move_enable = enable
	if move_enable:
		skills.HungerSkill.change_rate_to_fast()
		skills.ThirstySkill.change_rate_to_fast()
		skills.TireSkill.change_rate_to_fast()
	else:
		skills.HungerSkill.change_rate_to_slow()
		skills.ThirstySkill.change_rate_to_slow()
		skills.TireSkill.change_rate_to_slow()

func set_direction(dir:Vector2):
	move_dir = dir


