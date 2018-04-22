extends Area2D

signal destroyed()

func _ready():
	connect('body_entered', self, 'on_hit')

func on_hit(other):
	if visible:
		$PopSfx.play()
		emit_signal('destroyed')
		hide()
		$PopSfx.connect('finished', self, 'queue_free')
