extends Node
class_name Database

signal data_changed(k, newValue, oldValue)
signal data_collection_removed(k, collection, i, removedValue)
signal data_collection_inserted(k, collection, i, insertedValue)
signal data_collection_updated(k, collection, i, newValue, oldValue)
signal data_collection_cleared(k, collection)


onready var data = get_child(0)

func _init() -> void:
	connect("data_changed", self, "_on_data_changed")
	connect("data_collection_removed", self, "_on_data_collection_removed")
	connect("data_collection_inserted", self, "_on_data_collection_inserted")
	connect("data_collection_updated", self, "_on_data_collection_updated")
	connect("data_collection_cleared", self, "_data_collection_cleared")

func _get(property: String):
	return get_data(property)

func _set(property: String, value) -> bool:
	if data.has(property):
		set_data(property, value)
		return true
	return false

func _ready() -> void:
	for k in data.keys():
		set_data(k, data[k])

#----- Methods -----
func watch(k, obj, method):
	add_watcher(k, obj, method)

func add_watcher(k, obj, method):
	connect(k + "_data_changed", obj, method)

func set_data(k, v):
	var old = get_data(k)
	if not has_user_signal(k + "_data_changed"):
		add_user_signal(k + "_data_changed")
		add_user_signal(k + "_data_collection_removed")
		add_user_signal(k + "_data_collection_inserted")
		add_user_signal(k + "_data_collection_updated")
		add_user_signal(k + "_data_collection_cleared")
		
	
	data[k] = v
	emit_signal("data_changed", k, v, old)

func get_data(k):
	if data.has(k):
		return data[k]
	return null
	
func array_data_insert(k, i, v):
	var a = get_data(k) as Array
	assert(a != null)
	a.insert(i, v)
	emit_signal("data_collection_inserted", k, a, i, v)

func array_data_append(k, v):
	var a = get_data(k) as Array
	assert(a != null)
	a.push_back(v)
	emit_signal("data_collection_inserted", k, a, a.size()-1, v)

func array_data_remove(k, i:int):
	var a = get_data(k) as Array
	assert(a != null)
	var v = a[i]
	a.remove(i)
	emit_signal("data_collection_removed", k, a, i, v)

func array_data_erase(k, v):
	var a = get_data(k) as Array
	assert(a != null)
	var i = a.find(v)
	a.erase(v)
	emit_signal("data_collection_removed", k, a, i, v)

func array_data_update(k, i, v):
	var a = get_data(k) as Array
	assert(a != null)
	var old = a[i]
	a[i] = v
	emit_signal("data_collection_updated", k, a, i, v, old)

func array_data_clear(k):
	var a = get_data(k) as Array
	assert(a != null)
	a.clear()
	emit_signal("data_collection_cleared", k, a)

func dictionary_data_set(k, i, v):
	var d = get_data(k) as Dictionary
	assert(d != null)
	d[i] = v
	emit_signal("data_collection_inserted", k, d, i, v)

func dictionary_data_remove(k, i):
	var d = get_data(k) as Dictionary
	assert(d != null)
	var v = d[i]
	d.erase(i)
	emit_signal("data_collection_removed", k, d, i, v)

func dictionary_data_clear(k):
	var d = get_data(k) as Dictionary
	assert(d != null)
	d.clear()
	emit_signal("data_collection_cleared", k, d)

#----- Singals -----
func _on_data_changed(k, newValue, oldValue):
	emit_signal(k + "_data_changed", newValue, oldValue)

func _on_data_collection_removed(k, collection, i, removedValue):
	emit_signal(k + "_data_collection_removed", collection, i, removedValue)
	emit_signal('data_changed', collection, collection)

func _on_data_collection_inserted(k, collection, i, insertedValue):
	emit_signal(k + "_data_collection_inserted", collection, i, insertedValue)
	emit_signal('data_changed', collection, collection)

func _on_data_collection_updated(k, collection, i, newValue, oldValue):
	emit_signal(k + "_data_collection_updated", collection, i, newValue, oldValue)
	emit_signal('data_changed', collection, collection)

func _on_data_collection_cleared(k, collection):
	emit_signal(k + "_data_collection_cleared", collection)
	emit_signal('data_changed', collection, collection)


