extends RigidBody2D

#global variables:
var set_timer = false
var pending_teleport = false
var apply_upwards_acc = false
var apply_right_acc = false
var apply_left_acc = false


func _ready():
    position = Vector2(100, 100)
    set_process_input(true)


func _physics_process(_delta):
    var cam = get_viewport().get_camera_2d()
    #print("y = %s x = %s" % [position.y, position.x])

    #print("cam.y = %s cam.x = %s" % [cam.position.y, cam.position.x])

    ####
    # smooth camera movement (or at least as smooth as i could make it)
    ####
    cam.position.x = position.x
    if (position.y > cam.position.y): #camera goes down
        var change = min(1000, (abs(position.y - cam.position.y) / 10))
        cam.position.y += change #max change is much bigger cus you should always be able to see the fall
    if (position.y < cam.position.y): #camera goes up
        var change = min(100, (abs(cam.position.y - position.y) / 10))
        cam.position.y -= change

    if position.y > 1000 && !set_timer:
        var timer_code = Timer.new()
        add_child(timer_code) # Add it as a child to the scene tree
        timer_code.wait_time = 2.0 # Set the duration to 5 seconds
        timer_code.one_shot = true # Make it stop after one timer
        # Connect the timeout signal to a function in this script
        timer_code.timeout.connect(_on_timer_code_timeout)
        timer_code.start() # Start the timer
        set_timer = true

func _integrate_forces(state):
    if pending_teleport:
        state.transform.origin = Vector2(100, 100)
        state.linear_velocity = Vector2.ZERO
        pending_teleport = false

    if (apply_upwards_acc):
        state.apply_force(Vector2(0, -2500)) # apply a bit of upwards thrust
        print("apllying upwards thrust")
    if (apply_right_acc):
        state.apply_force(Vector2(500, 0)) # apply a bit of right thrust
        print("apllying right thrust")
    if (apply_left_acc):
        state.apply_force(Vector2(-500, 0)) # apply a bit of left thrust
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

func _on_timer_code_timeout():
    print("Timer finished!")
    print("teleporting")
    #set_deferred("position", Vector2(100, 100))
    #linear_velocity = Vector2.ZERO
    set_timer = false
    pending_teleport = true
