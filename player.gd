extends KinematicBody2D

var movement = Vector2(0, 0)
var air_time = 0
var time_since_jump_pressed = 0
var jump_time = 100

const GRAVITY = 2000
const MAX_FALL_SPEED = 1200
const RUN_SPEED = 600
const JUMP_VARI_TIME = 0.15
const MIN_JUMP = 200
const MAX_JUMP = 1200
const GROUND_ACCEL = 10
const AIR_ACCEL = 5

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed('game_swing'):
		get_tree().call_group('balls', 'player_swing', position + Vector2(0, -30))

func _physics_process(delta):
	movement.y = min(MAX_FALL_SPEED, movement.y + GRAVITY * delta)
	var input_x = 0
	if Input.is_action_pressed('game_right'):
		input_x = 1
	if Input.is_action_pressed('game_left'):
		input_x = -1
	var accel = AIR_ACCEL
	if is_on_floor():
		air_time = 0
		accel = GROUND_ACCEL
	else:
		air_time += delta
	if Input.is_action_just_pressed('game_jump'):
		time_since_jump_pressed = 0
	else:
		time_since_jump_pressed += delta
	jump_time += delta
	if Input.is_action_pressed('game_jump'):
		if jump_time < JUMP_VARI_TIME:
			movement.y = -(MAX_JUMP - MIN_JUMP) * sqrt(jump_time / JUMP_VARI_TIME) - MIN_JUMP
		elif air_time < 0.15 && time_since_jump_pressed < 0.15:
			movement.y = -MIN_JUMP
			air_time = 100
			jump_time = 0
	movement.x += (input_x * RUN_SPEED - movement.x) * delta * accel
	movement = move_and_slide(movement, Vector2(0, -1))
