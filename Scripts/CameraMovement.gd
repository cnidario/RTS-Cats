extends Camera2D

export var speed = 300.0
export var cam_speed = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	

func _process(delta):
	if cam_speed != Vector2.ZERO:
		self.set_position(self.get_position() + cam_speed * speed * delta)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("click") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		get_tree().set_input_as_handled() # consume the event
	# movimiento cámara acercándose a los bordes
	var viewport_size = get_viewport().size
	var mouse_position = get_viewport().get_mouse_position()
	if 	mouse_position.x == 0:
		cam_speed.x = -1
	elif mouse_position.x == viewport_size.x - 1:
		cam_speed.x = 1
	else:
		cam_speed.x = 0
	if mouse_position.y == 0:
		cam_speed.y = -1
	elif mouse_position.y == viewport_size.y - 1:
		cam_speed.y = 1
	else:
		cam_speed.y = 0
	if cam_speed != Vector2.ZERO:
		cam_speed = cam_speed.normalized()
	
