extends Panel

const Circle = preload("Circle.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# var pos
var epos
var size 
var TL_node

var circles = []

var circle_draw
var circle_erase
var duty_cycle = 0
var DUTY_COUNT = 1

var last_pos 

# Called when the node enters the scene tree for the first time.
func _ready():
	TL_node = get_node("TLPos")
	set_process(true)

func _draw():	
	draw_circles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# ESC maps to ui_cancel in project settings
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(_delta):
	duty_cycle += 1
	if duty_cycle > DUTY_COUNT:
		duty_cycle = 0
		update()
	
func _input(event):
	var circ
	var vsize = get_viewport_rect().size
	if vsize != size:
		print("Viewport Resolution is: ", vsize)
		size = vsize

	if event is InputEventMouseButton:
		if event.position != last_pos:
			last_pos = event.position
			circ = Circle.new(self, event.position, 5.0)
			circles.append(circ)
			# print("Mouse Click/Unclick at: ", event.position, event.global_position)
			update()

func draw_circles():
	var ncirc = []
	var circ
	var visible
	
	while len(circles) > 0:
		circ =  circles.pop_front()
		circ.draw_ring(self, Color.white, 1.0)
		ncirc.append(circ)

	while len(ncirc) > 0:
		circ =  ncirc.pop_front()
		visible = circ.draw_ring(self, Color.black, 1.0)
		if visible:
			circ.radius += 1
			circles.append(circ)
		else:
			print("dropping circle")		

