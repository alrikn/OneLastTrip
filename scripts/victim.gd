extends Node2D

const TEXTURES = [
    "res://assets/pixel_people/person001.png",
    "res://assets/pixel_people/person002.png",
    "res://assets/pixel_people/person003.png",
    "res://assets/pixel_people/person004.png",
    "res://assets/pixel_people/person005.png",
    "res://assets/pixel_people/person006.png",
    "res://assets/pixel_people/person007.png",
    "res://assets/pixel_people/person008.png",
    "res://assets/pixel_people/person009.png",
    "res://assets/pixel_people/person010.png",
    "res://assets/pixel_people/person011.png",
    "res://assets/pixel_people/person012.png",
    "res://assets/pixel_people/person013.png",
    "res://assets/pixel_people/person014.png",
    "res://assets/pixel_people/person015.png",
    "res://assets/pixel_people/robot.png",
    "res://assets/pixel_people/clown.png",
    "res://assets/pixel_people/astronaut 1.png",
    "res://assets/pixel_people/astronaut 2.png",
]

# Tune this: player must be moving slower than this (px/s) to collect
const COLLECT_SPEED_THRESHOLD = 100.0
const COLLECT_TIME := 3.0
var player: RigidBody2D = null

func _ready() -> void:
    $Area2D/Sprite2D.texture = load(TEXTURES[randi() % TEXTURES.size()])

    $Area2D.body_entered.connect(_on_body_entered)
    $Area2D.body_exited.connect(_on_body_exited)

    var timer := Timer.new()
    timer.name = "CollectTimer"
    timer.wait_time = COLLECT_TIME
    timer.one_shot = true
    timer.timeout.connect(_on_collect_timeout)
    add_child(timer)

func _physics_process(_delta: float) -> void:
    if player == null:
        return

    var speed := player.linear_velocity.length()

    if speed < COLLECT_SPEED_THRESHOLD:
        if $CollectTimer.is_stopped():
            $CollectTimer.start()
    else:
        $CollectTimer.stop()

func _on_body_entered(body: Node2D) -> void:
    if body is RigidBody2D:
        player = body

func _on_body_exited(body: Node2D) -> void:
    if body == player:
        player = null
        $CollectTimer.stop()

func _on_collect_timeout() -> void:
    if player and player.linear_velocity.length() < COLLECT_SPEED_THRESHOLD:
        print("collecting victim")
        queue_free()