extends Area2D
class_name Module

var port = preload("res://Scenes/Spaceship/port.tscn")

func _ready():
	instantiate_ports()

func instantiate_ports() :
	var vertecies : PackedVector2Array = $CollisionPolygon2D.polygon
	
	for i in range(vertecies.size()):
		# new port instantiation
		var new_port := port.instantiate()
		$Ports.add_child(new_port)
		new_port.name = "Port_" + str(i)
		
		# set new port position
		var start = vertecies[i]
		var end = vertecies[(i+1)%vertecies.size()]
		new_port.position = (start + end) / 2
		
		# set new port rotation
		var dir = start.direction_to(end)
		new_port.rotation = dir.orthogonal().angle() - new_port.rotation
		
		# setup new port
		var collision_shape : CollisionShape2D = new_port.get_node("CollisionShape2D")
		if (collision_shape != null):
			collision_shape.shape.size = Vector2(start.distance_to(end) * 0.75, collision_shape.shape.size.y)
