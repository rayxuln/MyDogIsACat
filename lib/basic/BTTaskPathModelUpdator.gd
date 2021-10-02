extends Node
class_name BTTaskPathModelUpdator

export(NodePath) var sourcePath
onready var source:Database = get_node(sourcePath)

export(String) var sourceProperty

export(bool) var exclude_guard:bool = true
export(bool) var full_path:bool = false

var current_task:BTNode

func _ready() -> void:
	current_task = null
	get_parent().connect('task_started', self, '_on_task_started')
	get_parent().connect('task_ended', self, '_on_task_ended')

#----- Signals -----
func _on_task_started(task):
	if current_task != task:
		if exclude_guard and 'Guards' in str(task.tree.get_path_to(task)):
			return
		current_task = task
		source.set_data(sourceProperty, str(current_task.tree.get_path_to(current_task)) if full_path else current_task.name)

func _on_task_ended(task):
	if current_task == task:
		current_task = null
		source.set_data(sourceProperty, '')

