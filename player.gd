extends RigidBody2D

#global variables:
var set_timer = false
var pending_teleport = false
var apply_upwards_acc = false


func _ready():
    position = Vector2(100, 100)
    set_process_input(true)


func _physics_process(_delta):
    var cam = get_viewport().get_camera_2d()
    print("y = %s x = %s" % [position.y, position.x])

    print("cam.y = %s cam.x = %s" % [cam.position.y, cam.position.x])

    cam.position.x = position.x
    #cam.position.y = position.y / 2

    if position.y > 500 && !set_timer:
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
        state.apply_force(Vector2(0, -3050)) # apply a bit of upwards thrust
        print("apllying upwards thrust")
    else:
        print("not apllying upwards thrust")

func _input(event: InputEvent) -> void:
    if (event.is_action_pressed("move_up")):
        apply_upwards_acc = true
        sleeping = false
    if (event.is_action_released("move_up")):
        apply_upwards_acc = false



func _on_timer_code_timeout():
    print("Timer finished!")
    print("teleporting")
    #set_deferred("position", Vector2(100, 100))
    #linear_velocity = Vector2.ZERO
    set_timer = false
    pending_teleport = true
