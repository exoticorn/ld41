extends Area2D

signal player_entered()

var player_entered = false

func _ready():
	connect('body_entered', self, 'on_body_entered')

func on_body_entered(o):
	if o.collision_layer & 4:
		emit_signal('player_entered')
		player_entered = true
	elif !player_entered:
		o.queue_free()