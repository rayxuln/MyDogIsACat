extends BaseSkillManager

var tracked_data_list = [
	'health',
	'hunger',
	'thirsty',
	'tire',
	'poop',
]

var current_task_list = []

func _ready() -> void:
	for d in tracked_data_list:
		skills.Database.connect('%s_data_changed' % d, self, 'on_data_changed', [d])
		update_status_text(d, skills.Database[d])
	
	skills.Brain.connect('task_started', self, 'on_brain_task_start')
	skills.Brain.connect('task_ended', self, 'on_brain_task_end')

#----- Overrides -----
func get_denpendencies():
	return [
		'Database',
		'Brain',
		'HungerSkill'
		]
	
#----- Methods -----
func update_status_text(k, v):
	var displayer = CommonHelper.game_manager.get_status_display()
	displayer.set_status(k, handle_k_v(k, v))

func handle_k_v(k, v):
	match k:
		'hunger':
			var is_hungery = skills.HungerSkill.is_hungery()
			if is_hungery:
				return '%s (饥饿)' % v
	return v

func update_current_task_list_text():
	var s = '[\n'
	for task in current_task_list:
		s += str(skills.Brain.get_path_to(task)) + '\n'
	s += ']'
	update_status_text('current task', s)

#----- Signals -----
func on_data_changed(newValue, oldValue, k):
	update_status_text(k, newValue)
	
func on_brain_task_start(task):
	if not task in current_task_list:
		current_task_list.append(task)
		update_current_task_list_text()
#		var displayer = CommonHelper.game_manager.get_status_display()
#		displayer.add_msg('task start: %s' % task.name)

func on_brain_task_end(task):
	if task in current_task_list:
		current_task_list.erase(task)
		update_current_task_list_text()
#		var displayer = CommonHelper.game_manager.get_status_display()
#		displayer.add_msg('task end: %s' % task.name)
	
	

