extends Area2D

func _ready():
	connect('body_entered', self, 'kill_player')

func kill_player(o):
	get_tree().reload_current_scene()