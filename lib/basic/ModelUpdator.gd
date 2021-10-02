extends Node
class_name ModelUpdator

export(NodePath) var sourcePath
onready var source:Database = get_node(sourcePath)

export(String) var sourceProperty
export(String) var targetSignal = "value_changed"



func _ready() -> void:
	get_parent().connect(targetSignal, self, '_on_property_update')

#----- Signals -----
func _on_property_update(v):
	source.set_data(sourceProperty, v)
