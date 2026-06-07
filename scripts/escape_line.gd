extends Node2D

const HALF_WIDTH := 50000.0
const HEIGHT := 100.0
const FONT_SIZE := 48
const LABEL_TEXT := "ESCAPE  "

var _font: Font

func _ready() -> void:
	_font = load("res://assets/VT323-Regular.ttf")

func _draw() -> void:
	draw_rect(Rect2(-HALF_WIDTH, -HEIGHT / 2.0, HALF_WIDTH * 2.0, HEIGHT), Color.RED)
	if _font == null:
		return
	var step := _font.get_string_size(LABEL_TEXT, HORIZONTAL_ALIGNMENT_LEFT, -1, FONT_SIZE).x
	if step <= 0.0:
		return
	var y_baseline := HEIGHT * 0.2
	var x := -HALF_WIDTH
	while x < HALF_WIDTH:
		draw_string(_font, Vector2(x, y_baseline), LABEL_TEXT, HORIZONTAL_ALIGNMENT_LEFT, -1, FONT_SIZE, Color.WHITE)
		x += step
