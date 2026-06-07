extends CanvasLayer

@onready var game_label: Label = $GamePanel/GameLabel

func _process(_delta: float):
	var minutes: int = int(Global.time_left) / 60
	var seconds: int = int(Global.time_left) % 60
	var time_string: String = "Time: %02d:%02d" % [minutes, seconds]
	var score_string: String = "Score: %d" % Global.score
	game_label.text = score_string + "\n" + time_string
