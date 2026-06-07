extends Node

var player_state: Node = null
var time_left: float = 300.0
var score: int = 0
var high_score: int = 0
var is_game_active: bool = false
var win: bool = false
# The following variable is in comments cuz its just an experiment
# var game_over_scene = preload("res://Scenes/menu/game_over.tscn")
const SAVE_PATH = "user://highscore.save"

func reset_game():
	time_left = 300.0
	score = 0
	is_game_active = true
	win = false
	#There's no need to respawn the victims,
	#they respawn automatically when the game is reset.

func _ready():
	load_high_score()

func load_high_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_score = file.get_32()
		file.close()
	else:
		high_score = 0

func save_high_score():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_32(high_score)
	file.close()

func check_high_score():
	if win and score > high_score:
		high_score = score
		save_high_score()

func _process(delta: float):
	if is_game_active:
		if time_left > 0:
			time_left -= delta
		else:
			time_left = 0
			is_game_active = false
			get_tree().change_scene_to_file("res://Scenes/menu/game_over.tscn")
