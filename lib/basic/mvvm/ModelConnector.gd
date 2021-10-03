extends Node
class_name ModelConnector

export(NodePath) var sourcePath
onready var source:Database = get_node(sourcePath)

export(String) var sourceProperty
export(String) var targetProperty = "value"
export(String) var targetSignal = "value_changed"

var updating:bool = false

func _ready() -> void:
	if not targetSignal.empty():
		if get_parent().has_signal(targetSignal):
			get_parent().connect(targetSignal, self, "_on_update_property")
		else:
			printerr("%s does not have signal %s" % [get_parent().name, targetSignal])
	
	get_parent().set(targetProperty, source[sourceProperty])
	source.connect(sourceProperty + "_data_changed", self, "_on_data_changed")
	

#----- Methods -----


#----- Signals -----
func _on_data_changed(newValue, oldValue):
	if not updating:
		get_parent().set(targetProperty, newValue)

func _on_update_property(value):
	updating = true
	source[sourceProperty] = value
	updating = false
