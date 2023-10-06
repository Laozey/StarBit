extends Area2D

@export var module_scene = preload("res://Scenes/Spaceship/square.tscn")
@onready var preview_shader_material = preload("res://Art/Shaders/preview_shader_material.tres")
var brush_content
var is_module_on_target = false
var target_port = null
var ports_in_range: Array[Port]

func _ready():
	set_brush_content(module_scene)

func _input(_event):
	position = get_global_mouse_position()
	
	if ports_in_range.size() > 0:
		var port = select_nearest_port()
		if target_port != port:
			target_port = port
			attach_preview()
	elif is_module_on_target:
		swap_preview(self)
		brush_content.position = Vector2.ZERO
		is_module_on_target = false

func _on_area_entered(area):
	if area is Port:
		ports_in_range.append(area)

func _on_area_exited(area):
	if area is Port:
		ports_in_range.remove_at(ports_in_range.find(area))

func set_brush_content(scene):
	brush_content = scene.instantiate()
	add_child(brush_content)
	brush_content.deactivate_ports()
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

func attach_preview():
	swap_preview(target_port)
	is_module_on_target = true
	target_port.part_added.emit(brush_content)

func swap_preview(new_parent):
	var parent = brush_content.get_parent()
	brush_content.visible = true
	
	if parent != null:
		parent.remove_child(brush_content)
	
	new_parent.add_child(brush_content)
