extends Module

func rearrange_ports() :
	var offset = side_length/2
	var ports_position = [
		Vector2(0, -offset),
		Vector2(offset, 0),
		Vector2(0, offset),
		Vector2(-offset, 0)
	]
	var rot = 0
	
	for i in range(4):
		ports[i].position = ports_position[i]
		ports[i].rotation_degrees = rot
		rot += 90
		
