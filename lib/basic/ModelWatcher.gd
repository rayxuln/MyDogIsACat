extends Node
class_name ModelWatcher

export(bool) var connect_on_ready:bool = true

export(NodePath) var sourcePath
var source:Database

export(String) var property:String = ''
export(String) var listener:String = ''

export(String, 'ONE_ARG', 'TWO_ARG') var mode:String = 'ONE_ARG'


func _ready() -> void:
	if not connect_on_ready:
		return
	if not source:
		source = get_node(sourcePath)
	set_source(source)
	
		
#----- Methods -----
func set_source(s):
	source = s
	if mode == 'TWO_ARG':
		source.watch(property, get_parent(), listener)
		get_parent().call(listener, source[property], source[property])
	elif mode == 'ONE_ARG':
		source.watch(property, self, '_on_property_changed')
		get_parent().call(listener, source[property])

#----- Signals -----
func _on_property_changed(newValue, oldValue):
	get_parent().call(listener, newValue)
