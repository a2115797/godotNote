shader_type canvas_item;

uniform sampler2D img;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 _uv = UV;
	_uv = _uv * 2.0;
	/*
		向下取整，保证每一段uv坐标都是0-1，相当于坐标偏移量。
		坐标轴 0-1-2-3-4,每个区间内的坐标取整后为0,1,2,3,4等整数
	*/
	vec2 id = floor(_uv); 
	_uv = _uv - id; // 每个区间中的数减去id（上一个区间的整数）获得当前渲染区间的坐标原点
	COLOR = texture(img, _uv);
	COLOR = vec4(_uv, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
