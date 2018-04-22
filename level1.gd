extends Node

func _ready():
	yield($Section1/PlayerTrigger, 'player_entered')
	$Section1/Cannon.activate()
	yield($Section1/Balloon, 'destroyed')
	$Section1/Cannon.queue_free()
	yield($Section2/PlayerTrigger, 'player_entered')
	$Section2/Cannon.activate()
	yield($Section2/Balloon, 'destroyed')
	$Section2/Cannon.queue_free()
	yield($Section3/PlayerTrigger, 'player_entered')
	$Section3/Cannon.activate()
	yield($Section3/Balloon, 'destroyed')
	$Section3/Cannon.queue_free()
	yield($Section4/Balloon, 'destroyed')
	$Section4/PlayerTrigger.queue_free()
