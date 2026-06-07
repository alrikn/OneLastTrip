extends Node

var player_state: Node = null
var time_left: float = 300.0
var score: int = 0
var is_game_active: bool = false
# There's a ton of other variables we could add here: max_people, max_platforms, etc.
# But for now, we'll just keep it simple.

func reset_game():
	time_left = 300.0
	score = 0
	is_game_active = true

func _process(delta: float):
	if is_game_active:
		if time_left > 0:
			time_left -= delta
		else:
			time_left = 0
			is_game_active = false
