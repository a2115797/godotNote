shader_type canvas_item;

uniform sampler2D tex;
uniform vec2 center = vec2(0.0, 0.0);
uniform float angle = 0.0;

/*
	自定义旋转 
	UVs UV坐标或世界坐标等映射矩阵
	RotationCenter 旋转中心坐标， 若使用UV坐标系，UV是[0,1]范围，因此[0.5,0.5]是UV映射的中心点
	RotationAngle 旋转角度， 接收 0-1 的值，值为1等于旋转360度
*/
vec2 customRotator(vec2 UVs, vec2 RotationCenter, float RotationAngle) {
	vec2 _uv = UVs + RotationCenter * -1.0; // 偏移
	float angle_cos = cos(RotationAngle);
	float angle_sin = sin(RotationAngle);
	vec2 _a = vec2(angle_cos, angle_sin * -1.0);
	vec2 _b = vec2(angle_sin,  angle_cos);
	
	return vec2(dot(_uv, _a), dot(_uv, _b)) + RotationCenter;
}

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
	vec2 _uv = UV;
	//COLOR = vec4(_uv, 0.0, 1);
	
	// 旋转CALOR
	COLOR = vec4(customRotator(_uv, center, angle), 0.0, 1);
	
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
