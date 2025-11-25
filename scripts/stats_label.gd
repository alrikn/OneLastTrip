extends Label

@onready var player_state = $"../../../Player/PlayerState"

func _physics_process(_delta):
    if player_state == null:
        text = "PlayerState not found"
        return

    text = "Velocity: %.2f\nRotation: %.2f\nHeight: %.1f" % [
        player_state.linear_vel,
        player_state.angular_vel,
        player_state.height
    ]
