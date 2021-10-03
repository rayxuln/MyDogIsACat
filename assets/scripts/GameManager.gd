extends Node

func _enter_tree() -> void:
	CommonHelper.game_manager = self

func _ready() -> void:
	# 延迟几秒加载游戏世界
	# 以便让游戏系统正确初始化完毕
	yield(get_tree().create_timer(0.3), 'timeout')
	$WorldNode.add_child(preload('res://World.tscn').instance())

#----- Methods -----
func get_world():
	return get_node('WorldNode/World')

func get_room_start():
	return get_world().get_room_start().global_position

func get_room_end():
	return get_world().get_room_end().global_position

func get_status_display():
	return $Control/StatusDisplay
