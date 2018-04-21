extends Node

func _ready():
	yield($Balloon, 'destroyed')
	$Cannon.queue_free()
	$Cannon2.activate()