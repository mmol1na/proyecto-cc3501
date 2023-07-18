extends Node

var mesh3d_load
@onready var fd_load = $FD_Load
var has_loaded = false
@onready var camera_3d = $CanvasLayer/Camera3D
@onready var crt = $CRTLayer/CRT
@onready var crt_label = $CanvasLayer/Sliders/CRTLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	var shader = get_node("ColorRect").get_material()
	var size_button = get_node("CanvasLayer/Sliders/pixelButton")
	var color_slider = get_node("CanvasLayer/Sliders/SliderColores")
	var color_label = get_node("CanvasLayer/Sliders/Colores")
	
	shader.set_shader_parameter("pixel_size", 1.0)
	color_slider.value = color_slider.max_value
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var shader = get_node("ColorRect").get_material()
	var size_button = get_node("CanvasLayer/Sliders/pixelButton")
	var color_slider = get_node("CanvasLayer/Sliders/SliderColores")
	var color_label = get_node("CanvasLayer/Sliders/Colores")
	
	var id = size_button.get_selected_id()
	var size = float(size_button.get_item_text(id))
	
	shader.set_shader_parameter("pixel_size", size)
	
	var n_colores = color_slider.get_value()
	
	shader.set_shader_parameter("n_colores", n_colores)
	color_label.text = "Cantidad de colores: {n}".format({"n": str(n_colores ** 3)})
	
	if crt.visible:
		crt_label.add_theme_color_override("font_color",Color(0.0,1.0,0.0))
		crt_label.text = "CRT FILTER: ON"
	else:
		crt_label.add_theme_color_override("font_color",Color(1.0,0.0,0.0))
		crt_label.text = "CRT FILTER: OFF"
		

func _on_fd_load_file_selected(path):
	has_loaded = true
	var load_file = load(path)
	var mesh3d_load = MeshInstance3D.new()
	mesh3d_load.set_mesh(load_file)
	mesh3d_load.set_name("Model3D")
	call_deferred("add_child", mesh3d_load)
	
	# Set correct size
	var og_aabb = mesh3d_load.get_aabb()
	var scale_factor = 4.4 / og_aabb.size.y 
	mesh3d_load.scale = Vector3(scale_factor,scale_factor,scale_factor)
	
	# Set center position relative to the viewport
	var cam_center = Vector3()
	cam_center.x = 0
	cam_center.y = -0.25
	cam_center.z = og_aabb.position.z + 0.2
	mesh3d_load.translate(cam_center)
	
	# Make the model rotate
	var rotate_script = load("res://Scripts/rotate.gd")
	mesh3d_load.set_script(rotate_script)
	

func _on_load_button_pressed():
	if has_loaded:
		var model = $Model3D
		model.queue_free()
	fd_load.visible = true

func _on_fd_load_canceled():
	has_loaded = false
	
func _input(event):
	if Input.is_key_pressed(KEY_C):
		crt.visible = not crt.visible
		
