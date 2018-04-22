extends KinematicBody2D

var movement = Vector2(0, 0)
var air_time = 0
var time_since_jump_pressed = 0
var jump_time = 100
var wall_jump_time = 100
var one_shot_done = true
var wall_dir = 0

const GRAVITY = 2500
const WALL_GRAVITY = 1000
const MAX_FALL_SPEED = 1200
const MAX_WALL_FALL_SPEED = 600
const RUN_SPEED = 750
const JUMP_VARI_TIME = 0.2
const MIN_JUMP = 300
const MAX_JUMP = 1450
const WALL_JUMP = 1200
const WALL_JUMP_HOR = 1000
const WALL_JUMP_TIME = 0.4
const GROUND_ACCEL = 8500
const AIR_ACCEL = 3700

func _ready():
	$AnimatedSprite.connect("animation_finished", self, 'animation_finished')
	pass

func _process(delta):
	if Input.is_action_just_pressed('game_swing'):
		get_tree().call_group('balls', 'player_swing', position + Vector2(-25, -30))
		$AnimatedSprite.play('swing')
		one_shot_done = false
	
	if !one_shot_done:
		pass
	elif is_on_wall():
		$AnimatedSprite.animation = 'slide'
		$AnimatedSprite.flip_h = wall_dir > 0
	elif !is_on_floor():
		$AnimatedSprite.animation = 'jump'
	else:
		$AnimatedSprite.animation = 'run'
		if abs(movement.x) > 20:
			$AnimatedSprite.playing = true
		else:
			$AnimatedSprite.playing = false
	$AnimatedSprite.flip_h = $AnimatedSprite.animation == 'slide' && wall_dir > 0

func _physics_process(delta):
	var gravity = GRAVITY
	var max_fall_speed = MAX_FALL_SPEED
	if is_on_wall() && movement.y >= 0:
		gravity = WALL_GRAVITY
		max_fall_speed = MAX_WALL_FALL_SPEED
	movement.y = min(max_fall_speed, movement.y + gravity * delta)
	var input_x = 0
	if Input.is_action_pressed('game_right'):
		input_x = 1
	if Input.is_action_pressed('game_left'):
		input_x = -1
	var accel = AIR_ACCEL
	if is_on_floor():
		air_time = 0
		accel = GROUND_ACCEL
		wall_jump_time = 100
	else:
		air_time += delta
	if Input.is_action_just_pressed('game_jump'):
		time_since_jump_pressed = 0
	else:
		time_since_jump_pressed += delta
	jump_time += delta
	if is_on_wall():
		wall_dir = 0
		for i in range(get_slide_count()):
			var c = get_slide_collision(i)
			if abs(c.normal.y) < 0.01 && c.collider is TileMap:
				wall_dir += c.normal.x
	if Input.is_action_pressed('game_jump'):
		if jump_time < JUMP_VARI_TIME:
			movement.y -= (MAX_JUMP - MIN_JUMP) / 3 / JUMP_VARI_TIME * delta
		elif air_time < 0.15 && time_since_jump_pressed < 0.15:
			movement.y = -(MIN_JUMP + MAX_JUMP) * 2 / 3
			air_time = 100
			jump_time = 0
		elif is_on_wall() && time_since_jump_pressed < 0.15:
			if wall_dir != 0:
				movement.y = -WALL_JUMP
				movement.x = WALL_JUMP_HOR * sign(wall_dir)
				jump_time = 100
				wall_jump_time = 0
	elif jump_time < JUMP_VARI_TIME:
		movement.y += (MAX_JUMP - MIN_JUMP) / 2 / JUMP_VARI_TIME * delta
	var target_x = input_x * RUN_SPEED
	var step = delta * accel
	if wall_jump_time < WALL_JUMP_TIME:
		step *= wall_jump_time / WALL_JUMP_TIME
	wall_jump_time += delta
	if target_x < movement.x:
		movement.x = max(target_x, movement.x - step)
	else:
		movement.x = min(target_x, movement.x + step)
	movement = move_and_slide(movement, Vector2(0, -1))

func animation_finished():
	one_shot_done = true