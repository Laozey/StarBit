extends Area2D
class_name Port

var attached_part

signal part_added(area: Area2D)

#func _draw():
#	var rect = $CollisionShape2D.shape.get_rect()
#	rect.size += Vector2.ONE * 2
#	rect.position.y += rect.size.y/2 - 2.
#	rect.position.x -= 1.
#	draw_rect(rect, Color.DARK_ORANGE, false)
#	draw_line(Vector2.ZERO, $CollisionShape2D.position*4., Color.AQUA)

func _on_part_added(area):
	area.position = Vector2(0, area.side_length/2)

func deactivate_port():
	$CollisionShape2D.disabled = true
	
