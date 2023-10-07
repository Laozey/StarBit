extends Area2D

@export var module_scene = preload("res://Scenes/Spaceship/square.tscn")
@onready var preview_shader_material = preload("res://Art/Shaders/preview_shader_material.tres")
var brush_content
var target_port = null
var ports_in_range: Array[Port]

func _ready():
	set_brush_content(module_scene)

func _input(_event):
	position = get_global_mouse_position()
	
	if ports_in_range.size() == 0: return
	
	var port = select_nearest_port()
	if port != target_port:
		target_port = port
		swap_preview(target_port)
		target_port.part_added.emit(brush_content)

func _on_area_entered(area):
	if area is Port:
		ports_in_range.append(area)

func _on_area_exited(area):
	if area is Port:
		ports_in_range.remove_at(ports_in_range.find(area))
		
		if ports_in_range.size() == 0:
			swap_preview(self)
			target_port = null
			brush_content.position = Vector2.ZERO

func set_brush_content(scene):
	brush_content = scene.instantiate()
	add_child(brush_content)
	brush_content.deactivate()
	brush_content.material = preview_shader_material

func select_nearest_port():
	var port = ports_in_range[0]
	var smaller_dist = global_position.distance_to(port.global_position)
	for i in range(1, ports_in_range.size()):
		var dist = global_position.distance_to(ports_in_range[i].global_position)
		if dist < smaller_dist:
			port = ports_in_range[i]
			smaller_dist = dist
	
	return port

func swap_preview(new_parent):
	var parent = brush_content.get_parent()
	if parent != null:
		parent.remove_child(brush_content)
	new_parent.call_deferred("add_child", brush_content)
