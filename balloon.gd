extends Area2D

signal destroyed()

func _ready():
	connect('body_entered', self, 'on_hit')

func on_hit(other):
	emit_signal('destroyed')
	queue_free()