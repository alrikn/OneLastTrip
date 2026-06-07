extends Control

@onready var result_label: Label = $ResultLabel
@onready var score_label: Label = $ScoreLabel
@onready var high_score_label: Label = $HighScoreLabel

func _ready() -> void:
	$RestartButton.pressed.connect(_on_restart_button_pressed)
	score_label.text = "Score: " + str(Global.score)
	high_score_label.text = "Highscore: " + str(Global.score)
	if Global.win:
		result_label.text = "MISSION ACCOMPLISHED!"
		result_label.label_settings.font_color = Color.GREEN
	else:
		result_label.text = "GAME OVER"
		result_label.label_settings.font_color = Color.CRIMSON

func _on_restart_button_pressed():
	Global.reset_game()
	get_tree().change_scene_to_file("res://main.tscn")
