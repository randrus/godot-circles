extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var center: Vector2
var max_radius: float
var radius: float
var canvas

func _init(_canvas, _center, _radius):
	canvas = _canvas
	center = _center
	radius = _radius
		
#func draw():
#	if radius*radius < max_radius:
#		draw_ring(Color.black, 1.0)
#	
#func erase():
#	if radius*radius <= max_radius:
#		draw_ring(Color.white, 1.0)


func draw_ring(node, color, resolution):
	var rect = canvas.get_rect()
	var circle_radius = Vector2(radius,0.0)
	var draw_counter = 1
	var line_origin = Vector2()
	var line_end = Vector2()
	var visible = false
	
	line_origin = circle_radius + center

	while draw_counter <= 360:
		line_end = circle_radius.rotated(deg2rad(draw_counter)) + center
		node.draw_line(line_origin, line_end, color)
		if visible == false:
			if rect.has_point(line_origin) or rect.has_point(line_end):
				visible = true
		draw_counter += 1 / resolution
		line_origin = line_end

	line_end = circle_radius.rotated(deg2rad(360)) + center
	node.draw_line(line_origin, line_end, color)
	return visible
	

	
	
	
