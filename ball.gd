extends RigidBody2D

var lifetime = 0
const MAX_HIT_DISTANCE = 250
const HIT_SPEED = 1500
const BALL_BOUNCE = 0.5

func _ready():
	pass

func _process(delta):
	lifetime += delta
	if lifetime > 8:
		queue_free()

func player_swing(pos):
	var delta = global_position - pos
	if delta.length() < MAX_HIT_DISTANCE:
		delta = delta.normalized()
		linear_velocity += delta.normalized() * (HIT_SPEED - delta.dot(linear_velocity) * (1 + BALL_BOUNCE))