extends Node2D


export(NodePath) var room_start_np
export(NodePath) var room_end_np

#----- Methods -----
func get_room_start():
	return get_node(room_start_np)

func get_room_end():
	return get_node(room_end_np)
