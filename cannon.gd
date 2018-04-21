extends Node2D

export (float) var SPEED = 1200
export (float) var VARIANCE = 200
export (float) var TIME_BETWEEN_BALLS = 4
export (float) var INITIAL_DELAY = 1

var ball_template = load("res://ball.tscn")
var timer = INITIAL_DELAY

func _ready():
	pass

func _process(delta):
	timer -= delta
	if timer <= 0:
		timer = TIME_BETWEEN_BALLS
		var ball = ball_template.instance()
		ball.position = position
		ball.linear_velocity = transform.y * SPEED
		ball.linear_velocity += Vector2(rand_range(-0.5, 0.5), rand_range(-0.5, 0.5)) * VARIANCE
		get_parent().add_child(ball)
