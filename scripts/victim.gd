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

func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D/Sprite2D.texture = load(TEXTURES[randi() % TEXTURES.size()])

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body.linear_velocity.length() < COLLECT_SPEED_THRESHOLD:
		queue_free()
