extends RigidBody2D

var lifetime = 0

func _ready():
	pass

func _process(delta):
	lifetime += delta
	if lifetime > 8:
		queue_free()
