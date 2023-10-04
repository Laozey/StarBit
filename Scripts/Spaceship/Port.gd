extends Area2D
class_name Port

var targeted : bool = false :
	get:
		return targeted
	set(value):
		queue_redraw()
		targeted = value

func _draw():
	var color = Color.DARK_ORANGE if targeted else Color.AQUAMARINE
	var rect = $CollisionShape2D.shape.get_rect()
	rect.size += Vector2.ONE * 2
	rect.position.y += rect.size.y/2 - 2.
	rect.position.x -= 1.
	draw_rect(rect, color, false)
	draw_line(Vector2.ZERO, $CollisionShape2D.position*4., Color.AQUA)
