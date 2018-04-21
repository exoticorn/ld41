extends RigidBody2D

var lifetime = 0
const MAX_HIT_DISTANCE = 200
const MIN_HIT_DISTANCE = 70
const HIT_SPEED_MIN = 1000
const HIT_SPEED_MAX = 2000

func _ready():
	pass

func _process(delta):
	lifetime += delta
	if lifetime > 8:
		queue_free()

func player_swing(pos):
	var delta = position - pos
	var strength = 1 - (delta.length() - MIN_HIT_DISTANCE) / (MAX_HIT_DISTANCE - MIN_HIT_DISTANCE)
	if strength > 0:
		linear_velocity = delta.normalized() * (HIT_SPEED_MIN + min(1, strength) * (HIT_SPEED_MAX - HIT_SPEED_MIN))