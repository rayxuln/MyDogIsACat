extends Node

var game_manager

#----- Methods -----
func choose(arr):
	if not arr is Array:
		return arr
	if arr.size() == 0:
		return null
	return arr[randi() % arr.size()]

func get_room_rect():
	return [
		game_manager.get_room_start(),
		game_manager.get_room_end(),
	]
