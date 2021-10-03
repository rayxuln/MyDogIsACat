extends Node2D

var move_speed:float
var dir:Vector2

var gravity:float = 9.8
var velocity:Vector2 = Vector2.ZERO

var start_pos:Vector2

var moving:bool = false

func _physics_process(delta: float) -> void:
	if not moving:
		return
	
	velocity.y += gravity

	global_position += velocity * delta
	
	if global_position.y > start_pos.y + 0.5:
		velocity = Vector2.ZERO
		gravity = 0

#----- Methods -----
func init(s):
	$Label.text = s
	
	start_pos = global_position
	
	move_speed = rand_range(200, 300)
	dir = Vector2(rand_range(-1, 1), rand_range(-0.5, -1)).normalized()
	velocity = dir * move_speed
	
	moving = true

#----- Signals -----
func _on_LifeTimer_timeout() -> void:
	queue_free()
