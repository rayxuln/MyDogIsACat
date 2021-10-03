tool
extends BTActionTimer
class_name NodeDependencyBTActionTimer

var skills:Dictionary = {}

#----- Overrides -----
func get_denpendencies():
	return [
	]
#----- Methods -----
func start():
	.start()
	check_dependency()
	

func get_owner():
	return tree.agent

func get_input():
	return get_owner().get_node('InputManager')

func check_dependency():
	for d in get_denpendencies():
		var s = get_owner().get_node_or_null(d)
		if s == null:
			printerr('%s does not have %s skill manager.' % [get_owner().name, d])
			return
		else:
			skills[d] = s
