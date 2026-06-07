extends RigidBody2D

var set_timer = false
var pending_teleport = false
var exploding = false
var stabilising = false

# raw player inputs
var player_thrust = false
var player_rotate_right = false
var player_rotate_left = false

# active inputs computed each physics frame (player or stabiliser)
# kept as apply_* so exhaust.gd and other dependents still work
var apply_upwards_acc = false
var apply_right_acc = false
var apply_left_acc = false

@export var thrust_force: float = 1500.0
@export var torque_force: float = 4500.0

#camera controls
const MAX_CAMERA_DOWN = 1050.0 #the player can only be a maximum of 150 px down from the camera

func _ready():
	position = Vector2(100, 100)
	set_process_input(true)

func explode():
	exploding = true

	#set_process_input(false)
	sleeping = true
	freeze = true

	linear_velocity = Vector2.ZERO
	angular_velocity = 0

	$Sprite2D.hide()
	$Exhaust.hide()

	var explosion = $Explosion
	explosion.rotation = -rotation #to amke sure its upright
	explosion.show()
	explosion.frame = 0
	explosion.play("explosion")

	var frames = explosion.sprite_frames.get_frame_count("explosion")

	# Wait until animation finishes
	while explosion.frame < frames - 1:
		await get_tree().physics_frame

	explosion.hide()

	pending_teleport = true
	freeze = false
	sleeping = false
	#set_process_input(true)

	$Sprite2D.show()
	$Exhaust.show()
	exploding = false

func _physics_process(_delta):
	var cam = get_viewport().get_camera_2d()

	####
	# smooth camera movement (or at least as smooth as i could make it)
	####
	cam.position.x = position.x
	if (position.y > cam.position.y): #camera goes down
		#the camera should never be over MAX_CAMERA_DOWN over the player, as that would mean we don't see the player falling anymore
		# however, the camera shoul always move smoothly and never suddenly jar if it gets stuck at a limit

		var dist = position.y - cam.position.y #this should always be positive
		var percentage = dist / MAX_CAMERA_DOWN # the higher percentage is, the more change needs to be applied
		#if percentage reaches 0.99 or further, the change needs to be almost dist - MAX_CAMERA_DOWN right?
		var change = abs(percentage * (dist))
		cam.position.y += change
	if (position.y < cam.position.y): #camera goes up
		var change = abs(cam.position.y - position.y) / 3
		cam.position.y -= change

	if position.y > 100000 && !set_timer:
		var timer_code = Timer.new()
		add_child(timer_code)
		timer_code.wait_time = 2.0
		timer_code.one_shot = true
		timer_code.timeout.connect(_on_timer_code_timeout)
		timer_code.start()
		set_timer = true

# Fills apply_* flags from either player input or the stabiliser.
# Must run inside _integrate_forces so angular_velocity/linear_velocity are current.
func _compute_inputs(state: PhysicsDirectBodyState2D) -> void:
	if stabilising:
		# Rotation: bang-bang PD controller.
		# rot_combined > 0 means tilted/spinning clockwise → need counter-clockwise (left).
		# The 0.3 s look-ahead damps overshoot: we start correcting before hitting zero.
		var rot_combined = rotation + 0.3 * state.angular_velocity
		apply_left_acc  = rot_combined >  0.05
		apply_right_acc = rot_combined < -0.05
		# Thrust: only when close to upright so force is mostly upward,
		# and not already rising faster than 50 px/s (y-axis is down in Godot).
		apply_upwards_acc = abs(rotation) < 0.4 and state.linear_velocity.y > -50.0
	else:
		apply_upwards_acc = player_thrust
		apply_right_acc   = player_rotate_right
		apply_left_acc    = player_rotate_left

func _integrate_forces(state):
	if pending_teleport: #this is used to rest it if it goes out of bound or smth
		state.transform.origin = Vector2(100, -100)
		state.transform = Transform2D(0.0, state.transform.origin)
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0.0
		pending_teleport = false

	_compute_inputs(state)

	if apply_upwards_acc:
		var thrust_dir = Vector2.UP.rotated(rotation)
		apply_force(thrust_dir * thrust_force)
	if apply_right_acc:
		apply_torque(torque_force)
	if apply_left_acc:
		apply_torque(-torque_force)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
		player_thrust = true
		sleeping = false
	if event.is_action_released("move_up"):
		player_thrust = false
	if event.is_action_pressed("move_right"):
		player_rotate_right = true
		sleeping = false
	if event.is_action_released("move_right"):
		player_rotate_right = false
	if event.is_action_pressed("move_left"):
		player_rotate_left = true
		sleeping = false
	if event.is_action_released("move_left"):
		player_rotate_left = false
	if event.is_action_pressed("stabilise"):
		stabilising = true
		sleeping = false
	if event.is_action_released("stabilise"):
		stabilising = false
	if event.is_action_pressed("reset"):
		explode()

func _on_timer_code_timeout():
	print("Timer finished!")
	print("teleporting")
	set_timer = false
	pending_teleport = true
