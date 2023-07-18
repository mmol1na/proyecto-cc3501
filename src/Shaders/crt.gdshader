/*
Shader from Godot Shaders - the free shader library.
godotshaders.com/shader/VHS-and-CRT-monitor-effect

This shader is under CC0 license. Feel free to use, improve and 
change this shader according to your needs and consider sharing 
the modified result to godotshaders.com.
*/

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap_anisotropic;
uniform float pixel_size : hint_range(1.0,50.0) = 4.0;
uniform int color_depth : hint_range(1,256) = 5;

void fragment()
{
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 pixCoord = FRAGCOORD.xy;
	vec2 uv = floor(pixCoord/pixel_size)/floor(resolution/pixel_size);
	vec4 input = texture(SCREEN_TEXTURE, uv);
	vec4 img = vec4(floor(input.r*float(color_depth))/float(color_depth), floor(input.g*float(color_depth))/float(color_depth), floor(input.b*float(color_depth))/float(color_depth), input.a);
	COLOR = img;
}