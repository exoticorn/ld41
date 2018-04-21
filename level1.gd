extends Node

func _ready():
	yield($Section1/Balloon, 'destroyed')
	$Section1/Cannon.queue_free()
	$Section2/Cannon.activate()
	yield($Section2/Balloon, 'destroyed')
	$Section2/Cannon.queue_free()