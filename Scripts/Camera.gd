extends Camera3D
var speed = 10.0
var max_vertical_angle = deg_to_rad(90)
var min_vertical_angle = deg_to_rad(-90)
var mouse_locked = true
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion and mouse_locked:
		rotate_y(deg_to_rad(-event.relative.x * speed * get_physics_process_delta_time()))
		var new_rot_x = rotation.x + deg_to_rad(-event.relative.y * speed * get_physics_process_delta_time())
		new_rot_x = clamp(new_rot_x, min_vertical_angle, max_vertical_angle)
		rotation.x = new_rot_x
	if event is InputEventKey and Input.is_action_pressed("escape_key"):
		mouse_locked = not mouse_locked
		if mouse_locked:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _process(delta):
	if Input.is_action_pressed("move_forwards"):
		translate(Vector3(0, 0, -speed * delta))
	if Input.is_action_pressed("move_backwards"):
		translate(Vector3(0, 0, speed * delta))
	if Input.is_action_pressed("strafe_left"):
		translate(Vector3(-speed * delta, 0, 0))
	if Input.is_action_pressed("strafe_right"):
		translate(Vector3(speed * delta, 0, 0))
	if Input.is_action_pressed("move_upwards"):
		translate(Vector3(0, speed * delta, 0))
	if Input.is_action_pressed("move_downwards"):
		translate(Vector3(0, -speed * delta, 0))
