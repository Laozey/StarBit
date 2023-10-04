extends Area2D

@export var current : Module
var target_port : Port:
	get:
		return target_port
	set(value):
		target_port = value
		if value != null:
			target_port.targeted = true

var mouse_pos : Vector2

func _draw():
	var radius = $CollisionShape2D.shape.radius
	draw_arc(Vector2.ZERO, radius, 0, TAU, 20, Color.BLUE, .5, true)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.global_position
		move_brush()
		set_nearest_target_port()

func move_brush():
	position = mouse_pos

# set the nearest port in range as the new target
func set_nearest_target_port():
	var ports = get_overlapping_areas().filter(func(area): return area is Port)
	replace_target_port()
	if ports.size() > 0:
		target_port = ports[0]
		for i in range(1, ports.size()):
			swap_target_port(ports[i])

# swap target port with new one based on distance
func swap_target_port(new_port):
	var dist_new = new_port.global_position.distance_squared_to(mouse_pos)
	var dist_target_port = target_port.global_position.distance_squared_to(mouse_pos)
	if dist_new < dist_target_port:
		replace_target_port(new_port)

func replace_target_port(new_port: Port = null):
	if target_port != null:
		target_port.targeted = false
	target_port = new_port
