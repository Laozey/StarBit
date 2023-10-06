extends Area2D
class_name Module

var port_scene = preload("res://Scenes/Spaceship/port.tscn")
var side_length = 0

func _ready():
	instantiate_ports()

func instantiate_ports() :
	var vertecies : PackedVector2Array = $CollisionPolygon2D.polygon
	side_length = vertecies[0].distance_to(vertecies[1])
	for i in range(vertecies.size()):
		# new port instantiation
		var new_port := port_scene.instantiate()
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
			collision_shape.shape.size.x = side_length * 0.75

func deactivate_ports():
	for port in $Ports.get_children():
		port.deactivate_port()
