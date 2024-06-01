shader_type canvas_item;

uniform sampler2D img;

/*
	position：圆心位置
	radius: 半径
	feather: 羽化
	绘制圆形
*/
float circle(vec2 position, float radius, float feather) {
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

/*
	绘制实心正方形
*/
vec4 square(vec2 uv, float width) {
	uv = uv * 2.0 - 1.0;
	
	vec2 abs_uv = abs(uv.xy);
	float square = step(width, max(abs_uv.x, abs_uv.y));
	return vec4(vec3(square), 1.0);
}

/*
	绘制轮廓正方形
*/
vec4 square_stroke(vec2 uv, float width, float stroke_width) {
	uv = uv * 2.0 - 1.0;
	
	vec2 abs_uv = abs(uv.xy);
	float dist = max(abs_uv.x, abs_uv.y);
	vec3 stroke = 1.0 - vec3( step(width, dist) - step(width + stroke_width, dist));
	return vec4(vec3(stroke), 1.0);
}

/*
	绘制圆角矩形
*/
vec4 square_rounded(vec2 uv, float width, float radius) {
	uv = uv * 2.0 - 1.0;
	
	radius *= width; // make radius go from 0-1 instead of 0-widht
	vec2 abs_uv = abs(uv.xy) - radius;
	vec2 dist = vec2(max(abs_uv.xy, 0.0));
	float square = step(width - radius, length(dist));
	return vec4(vec3(square), 1.0);
}

void fragment() {
	//vec2 uv = UV;
	//// 偏移坐标定义圆中心位置，使坐标系从[0,1]变为[-0.5,0.5] 
	//uv = uv - 0.5;
	//// length 获取向量的长度，计算当前坐标距离圆心多远
	//float len = length(uv) * 2.0;
	//
	//vec4 tex = texture(img, UV);
	//COLOR = vec4(tex.r, tex.g, tex.b, 1.0 - len);
	
	//COLOR.rgb = vec3(circle(UV, 0.2, 0.005));
	
	// 制圆形遮罩
	//vec4 tex = texture(img, UV);
	//COLOR = vec4(tex.r, tex.g, tex.b, 1.0 - circle(UV, 0.4, 0.04));
	
	// 绘制圆角矩形遮罩
	vec4 tex = texture(img, UV);
	//COLOR = vec4(tex.r, tex.g, tex.b, 1.0 - square(UV, 0.4));
	//COLOR = square(UV, 0.8);
	//COLOR = square_stroke(UV, 0.9, 0.1);
	//COLOR = square_rounded(UV, 0.9, 0.9);
	
}