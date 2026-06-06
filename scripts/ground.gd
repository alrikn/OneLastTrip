extends StaticBody2D

func _ready():
	# Get the CollisionShape2D node
	var collision_shape = $CollisionShape2D
	var shape = collision_shape.shape

	# Check if the shape is a RectangleShape2D
	if shape is RectangleShape2D:
		create_polygon_from_rectangle(shape, collision_shape.position)
	else:
		push_error("Unsupported shape type: " + str(shape.get_class()))

func create_polygon_from_rectangle(rect_shape: RectangleShape2D, offset: Vector2):
	var size = rect_shape.size
	var half_size = size / 2

	# Create polygon points for a rectangle (clockwise winding)
	var polygon_points = PackedVector2Array([
		Vector2(-half_size.x, -half_size.y) + offset,  # Top-left
		Vector2(half_size.x, -half_size.y) + offset,   # Top-right
		Vector2(half_size.x, half_size.y) + offset,    # Bottom-right
		Vector2(-half_size.x, half_size.y) + offset    # Bottom-left
	])

	# Create and configure Polygon2D
	var polygon2d = Polygon2D.new()
	polygon2d.polygon = polygon_points
	polygon2d.color = Color(0.5, 0.5, 0.5)  # Gray color, change as needed

	# Add the Polygon2D as a child
	add_child(polygon2d)
