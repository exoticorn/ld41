extends Node2D

export (float) var SPEED = 1200
export (float) var VARIANCE = 200
export (float) var TIME_BETWEEN_BALLS = 3
export (float) var DELAY = 0
export (bool) var START_ACTIVATED = true

var ball_template = load("res://ball.tscn")
var timer = DELAY

func _ready():
	if !START_ACTIVATED:
		timer = 1000000

func _process(delta):
	timer -= delta
	if timer <= 0:
		timer = TIME_BETWEEN_BALLS
		var ball = ball_template.instance()
		ball.position = position
		ball.linear_velocity = transform.y * -SPEED
		ball.linear_velocity += Vector2(rand_range(-0.5, 0.5), rand_range(-0.5, 0.5)) * VARIANCE
		get_parent().add_child(ball)
		$ShootSfx.play()

func activate():
	timer = DELAY