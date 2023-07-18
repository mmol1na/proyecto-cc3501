shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear_mipmap_anisotropic;
uniform float pixel_size : hint_range(1.0,50.0) = 16.0;
uniform float n_colores : hint_range(2.0, 256.0) = 150.0;
uniform float spread_size: hint_range(0.0,50.0,1.0) = 20.0;

float bayer4(int x, int y, float c, float n) {
	mat4 m2 = mat4(
		vec4(0.0, 8.0, 2.0, 10.0),
		vec4(12.0, 4.0, 14.0, 6.0),
		vec4(3.0, 11.0, 1.0, 9.0),
		vec4(15.0, 7.0, 13.0, 5.0)
	);
	
	mat4 m2pre = (m2+1.0) / 16.0 - 0.5;
	
	float spread = 50.0;
	float M = m2pre[x][y];
	float M_normalized = M / 16.0;
	
	float c_prima = c + (spread * (M_normalized - 0.5));
	
	return floor(c * (n - 1.0) + 0.5) / (n - 1.0);
}

	
void fragment() {
	vec2 xy = FRAGCOORD.xy;
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = floor(xy/pixel_size)/floor(iResolution/pixel_size);
	// vec2 uv = FRAGCOORD.xy / iResolution.xy;
	
	int x = int(xy.x) % 4;
	int y = int(xy.y) % 4;
	float n = n_colores;
	
	vec4 canvas = texture(SCREEN_TEXTURE,uv);
	vec4 fragColor = vec4(bayer4(x,y,canvas.x,n),
	bayer4(x,y,canvas.y,n),
	bayer4(x,y,canvas.z,n),
	bayer4(x,y,canvas.a,n));
	
	COLOR = fragColor;
}
