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
	draw_arc(Vector2.ZERO, radius, 0, TAU, 20, Color.BLUE, -1., true)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
		move_brush()

func move_brush():
	position = mouse_pos

func _on_area_entered(area):
	if not area is Port:
		return
	
	var port = area
	
	# swap with new port if closer to cursor than target port else assign directly
	if target_port != null:
		swap_target_port(port)
	else:
		target_port = port

func _on_area_exited(area):
	if not area is Port:
		return
	
	var port = area
	
	# unselect target port and set to null if its the one exiting the brush radius
	if target_port == port:
		target_port.targeted = false
		target_port = null
	
	# set nearest port as target if there's one
	var nearest_ports = get_overlapping_areas().filter(func(area): return area is Port)
	if nearest_ports.size() > 0:
		target_port = nearest_ports[0]
		for i in range(1, nearest_ports.size()):
			swap_target_port(nearest_ports[i])

# swap target port with new one based on distance
func swap_target_port(new):
	var dist_new = new.position.distance_squared_to(mouse_pos)
	var dist_target_port = target_port.position.distance_squared_to(mouse_pos)
	if dist_new < dist_target_port:
		target_port.targeted = false
		target_port = new
