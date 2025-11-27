extends Node

@export var player: RigidBody2D

var linear_vel: float
var angular_vel: float
var height: float
var distance: float
var previous_velocity := Vector2.ZERO
var g_force := 0.0
var exploded := false
const PIXELS_PER_METER = 100.0

func _physics_process(_delta):
    if not is_instance_valid(player):
        return
    var current_velocity = player.linear_velocity / PIXELS_PER_METER
    linear_vel = player.linear_velocity.length() / PIXELS_PER_METER
    angular_vel = player.angular_velocity
    height = -player.position.y  / PIXELS_PER_METER
    distance = player.position.x / PIXELS_PER_METER
    var acceleration = (current_velocity - previous_velocity)# / delta #dlta is time change. here it is 1 tick so i am not putting it
    previous_velocity = current_velocity
    var accel_magnitude = acceleration.length()

    if (accel_magnitude > 6):
        exploded = true
        print("accel_magnitude = %.2f" % [accel_magnitude])

    #print("linear_vel = %s, angular_vel = %s, height = %s" % [linear_vel, angular_vel, height])
