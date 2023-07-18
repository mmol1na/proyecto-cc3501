extends ColorRect

@onready var label = $"../CanvasLayer/Sliders/PixelartLabel"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.visible:
		label.add_theme_color_override("font_color",Color(0.0,1.0,0.0))
		label.text = "PIXEL ART EFFECT: ON"
	else:
		label.add_theme_color_override("font_color",Color(1.0,0.0,0.0))
		label.text = "PIXEL ART EFFECT: OFF"
		
func _input(event):
	if Input.is_key_pressed(KEY_E):
		self.visible = not self.visible

	
