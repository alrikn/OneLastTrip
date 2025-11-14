extends Node

@export var player: RigidBody2D

var linear_vel: Vector2
var angular_vel: float
var height: float

func _physics_process(_delta):
    if not is_instance_valid(player):
        return

    linear_vel = player.linear_velocity
    angular_vel = player.angular_velocity
    height = -player.position.y
    print("linear_vel = %s, angular_vel = %s, height = %s" % [linear_vel, angular_vel, height])
