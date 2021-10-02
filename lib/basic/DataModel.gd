extends Node

class_name DataModel

var _keys = []

func _ready() -> void:
	for p in get_property_list():
		if p.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			if p.name[0] != "_":
				_keys.push_back(p.name)

#----- Methods ----
func keys():
	return _keys

func has(k:String):
	var ks = keys()
	return k in ks
