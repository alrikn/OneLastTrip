extends RigidBody2D

#global variables:
var set_timer = false
var pending_teleport = false
var apply_upwards_acc = false
var apply_right_acc = false
var apply_left_acc = false
var exploding = false #are we currently exploding?
@export var thrust_force: float = 2500.0
@export var torque_force: float = 5500.0

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
    #print("y = %s x = %s" % [position.y, position.x])

    #print("cam.y = %s cam.x = %s" % [cam.position.y, cam.position.x])

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
        #print("percentage = %.2f \t change = %.2f\t dist = %.2f" % [percentage, change, dist])
        cam.position.y += change
        #if (dist > MAX_CAMERA_DOWN): # theoretically we never get to this part
        #    cam.position.y = MAX_CAMERA_DOWN + position.y
        #cam.position.y = position.y
    if (position.y < cam.position.y): #camera goes up
        var change = abs(cam.position.y - position.y) / 3
        cam.position.y -= change

    if position.y > 100000 && !set_timer:
        var timer_code = Timer.new()
        add_child(timer_code) # Add it as a child to the scene tree
        timer_code.wait_time = 2.0 # Set the duration to 5 seconds
        timer_code.one_shot = true # Make it stop after one timer
        # Connect the timeout signal to a function in this script
        timer_code.timeout.connect(_on_timer_code_timeout)
        timer_code.start() # Start the timer
        set_timer = true

func _integrate_forces(state):
    if pending_teleport: #this is used to rest it if it goes out of bound or smth
        state.transform.origin = Vector2(100, -100)
        state.transform = Transform2D(0.0, state.transform.origin)
        state.linear_velocity = Vector2.ZERO
        state.angular_velocity = 0.0
        pending_teleport = false

    if (apply_upwards_acc):
        #state.apply_force(Vector2(0, -2500)) # apply a bit of upwards thrust
        # Rocket thrust relative to orientation
        var thrust_dir = Vector2.UP.rotated(rotation)
        apply_force(thrust_dir * thrust_force)
    if (apply_right_acc):
        #state.apply_force(Vector2(500, 0)) # apply a bit of right thrust
        apply_torque(torque_force)
        print("apllying right thrust")
    if (apply_left_acc):
        #state.apply_force(Vector2(-500, 0)) # apply a bit of left thrust
        apply_torque(-torque_force)
        print("apllying left thrust")

func _input(event: InputEvent) -> void:
    if (event.is_action_pressed("move_up")):
        apply_upwards_acc = true
        sleeping = false
    if (event.is_action_released("move_up")):
        apply_upwards_acc = false
    if (event.is_action_pressed("move_right")):
        apply_right_acc = true
        sleeping = false
    if (event.is_action_released("move_right")):
        apply_right_acc = false
    if (event.is_action_pressed("move_left")):
        apply_left_acc = true
        sleeping = false
    if (event.is_action_released("move_left")):
        apply_left_acc = false
    if (event.is_action_pressed("reset")):
        explode()

func _on_timer_code_timeout():
    print("Timer finished!")
    print("teleporting")
    #set_deferred("position", Vector2(100, 100))
    #linear_velocity = Vector2.ZERO
    set_timer = false
    pending_teleport = true
