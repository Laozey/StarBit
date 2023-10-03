extends Area2D
class_name Module

@export var side_length = 64

var ports : Array[Port]

func _ready():
	for node in get_children() :
		if node is Port :
			ports.append(node)

func rearrange_ports() :
	pass
