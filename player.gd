extends KinematicBody2D

var movement = Vector2(0, 0)
var air_time = 0
var time_since_jump_pressed = 0
var jump_time = 100

const GRAVITY = 2500
const MAX_FALL_SPEED = 1200
const RUN_SPEED = 750
const JUMP_VARI_TIME = 0.15
const MIN_JUMP = 300
const MAX_JUMP = 1600
const GROUND_ACCEL = 8500
const AIR_ACCEL = 3700

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
			movement.y -= (MAX_JUMP - MIN_JUMP) / 2 / JUMP_VARI_TIME * delta
		if air_time < 0.15 && time_since_jump_pressed < 0.15:
			movement.y = -(MIN_JUMP + MAX_JUMP) / 2
			air_time = 100
			jump_time = 0
	elif jump_time < JUMP_VARI_TIME:
		movement.y += (MAX_JUMP - MIN_JUMP) / 2 / JUMP_VARI_TIME * delta
	var target_x = input_x * RUN_SPEED
	var step = delta * accel
	if target_x < movement.x:
		movement.x = max(target_x, movement.x - step)
	else:
		movement.x = min(target_x, movement.x + step)
#	movement.x += (input_x * RUN_SPEED - movement.x) * delta * accel
	movement = move_and_slide(movement, Vector2(0, -1))
