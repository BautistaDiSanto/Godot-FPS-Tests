extends KinematicBody

onready var current_speed = base_speed
var acceleration = 20
var gravity = 9.8
export var base_speed = 7

onready var Jump1 = $Head/InteractRay/InGameUI/Control/JumpIndicator/JumpIcon1
onready var Jump2 = $Head/InteractRay/InGameUI/Control/JumpIndicator/JumpIcon2
var jump = 5
var available_jumps = 2
var jumped = 0

onready var DashIcon = $Head/InteractRay/InGameUI/Control/DashIcon
var dash_speed = 3
var dash_duration = 0.3
var dash_cooldown = 0.7
var can_dash = true

onready var head = $Head
var mouse_sensivility = 0.05

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Jump1.value = 100
	Jump2.value = 100

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
		Jump1.value = 100
		Jump2.value = 100
	else: 
		fall.y -= gravity * delta

	if (Input.is_action_just_pressed("jump")) and (jumped < available_jumps):
		jumped = jumped + 1
		if jumped == 2:
			Jump1.value = 0
			Jump2.value = 0
		else:
			Jump1.value = 0
			Jump2.value = 100
		fall.y = jump

	if (Input.is_action_just_pressed("dash") && can_dash):
		current_speed *= dash_speed
		can_dash = false
		
		DashIcon.value = 0

		yield(get_tree().create_timer(dash_duration), "timeout")

		current_speed = base_speed


		yield(get_tree().create_timer(dash_cooldown), "timeout")
			
		can_dash = true
		DashIcon.value = 100
		
	#yield(get_tree(), "script_changed")
	#if DashIcon.value < 100:
	#	DashIcon.value +=  dash_cooldown 1
	#else:

	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * current_speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	return move_and_slide(fall, Vector3.UP)
