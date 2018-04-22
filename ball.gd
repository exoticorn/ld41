extends RigidBody2D

var lifetime = 0
var bounce_count = 0
const MAX_HIT_DISTANCE = 200
const HIT_SPEED = 1500
const BALL_BOUNCE = 0.5

func _ready():
	connect("body_entered", self, 'count_bounce')
	pass

func _process(delta):
	lifetime += delta
	if lifetime > 8:
		queue_free()

func player_swing(pos):
	var delta = global_position - pos
	if delta.x < -MAX_HIT_DISTANCE:
		return
	$HitSfx.play()
	if delta.x < MAX_HIT_DISTANCE / 2:
		delta.x = MAX_HIT_DISTANCE / 2
	if delta.length() < MAX_HIT_DISTANCE:
		delta = delta.normalized()
		linear_velocity += delta.normalized() * (HIT_SPEED - delta.dot(linear_velocity) * (1 + BALL_BOUNCE))
		bounce_count = 0

func count_bounce(o):
	$HitSfx.play()
	bounce_count += 1
	if bounce_count >= 2:
		queue_free()