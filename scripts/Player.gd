extends KinematicBody

export var base_speed = 7
onready var current_speed = base_speed
var acceleration = 20
var gravity = 9.8

var jump = 5
var available_jumps = 2
var jumped = 0

var dash_speed = 3
var dash_duration = 0.3
var dash_cooldown = 0.7
var can_dash = true

var mouse_sensivility = 0.05

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensivility))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensivility))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _process(delta):

	direction = Vector3()

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z

	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z

	if Input.is_action_pressed("move_left"): 
		direction -= transform.basis.x

	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	if is_on_floor():
		jumped = 0
	else: 
		fall.y -= gravity * delta

	if (Input.is_action_just_pressed("jump")) and (jumped < available_jumps):
		jumped = jumped + 1
		fall.y = jump

	if (Input.is_action_just_pressed("dash") && can_dash):
		current_speed *= dash_speed
		can_dash = false

		yield(get_tree().create_timer(dash_duration), "timeout")

		current_speed = base_speed

		yield(get_tree().create_timer(dash_cooldown), "timeout")

		can_dash = true

	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * current_speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	return move_and_slide(fall, Vector3.UP)
