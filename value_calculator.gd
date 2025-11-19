extends Node

@export var player: RigidBody2D

var linear_vel: float
var angular_vel: float
var height: float
const PIXELS_PER_METER = 100.0

func _physics_process(_delta):
    if not is_instance_valid(player):
        return
    #lets call 100 pixels 1 meter (or smth)
    linear_vel = player.linear_velocity.length() / PIXELS_PER_METER
    angular_vel = player.angular_velocity
    height = -player.position.y  / PIXELS_PER_METER
    #print("linear_vel = %s, angular_vel = %s, height = %s" % [linear_vel, angular_vel, height])
