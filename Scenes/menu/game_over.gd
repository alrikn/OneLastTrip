extends Control

@onready var result_label: Label = $ResultLabel

func _ready() -> void:
	$RestartButton.pressed.connect(_on_restart_button_pressed)
	if Global.win:
		result_label.text = "MISSION ACCOMPLISHED!"
		result_label.label_settings.font_color = Color.GREEN
	else:
		result_label.text = "GAME OVER"
		result_label.label_settings.font_color = Color.CRIMSON

func _on_restart_button_pressed():
	Global.reset_game()
	get_tree().change_scene_to_file("res://main.tscn")
