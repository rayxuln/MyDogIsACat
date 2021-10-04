extends BaseSkillManager


export(float) var arrive_radius:float = 2

var target:Vector2 = Vector2.ZERO
var is_arrived:bool = true

func _process(delta: float) -> void:
	$X.modulate = Color.blue if is_arrived else Color.red
	if not is_arrived:
		var distance = target - get_current_position()
		if distance.length_squared() <= arrive_radius * arrive_radius:
			is_arrived = true
			skills.MovementSkill.set_move(false)
#			CommonHelper.game_manager.get_status_display().add_msg("Cat arrived at %s" % target)
		else:
			skills.MovementSkill.set_direction(distance.normalized())
			skills.MovementSkill.set_move(true)
	

#----- Overrides -----
func get_denpendencies():
	return ["MovementSkill"]
	
#----- Methods -----
func get_current_position():
	return get_owner().global_position

func set_target(t:Vector2):
	target = t
	$X.global_position = t

func go_to(t):
	if t is Vector2:
		set_target(t)
	is_arrived = false

func stop():
	is_arrived = true
	skills.MovementSkill.set_move(false)
