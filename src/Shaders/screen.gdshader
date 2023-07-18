shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap_anisotropic;

uniform float pixel_size : hint_range(1.0,50.0) = 16.0;
uniform int color_depth : hint_range(1,256) = 5;

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 pixCoord = FRAGCOORD.xy;
	vec2 uv = floor(pixCoord/pixel_size)/floor(resolution/pixel_size);
	vec4 input = texture(SCREEN_TEXTURE, uv);
	
	
	
	vec4 fragColor = vec4(input.r,input.g,input.b, input.a);
	COLOR = fragColor;
	}
