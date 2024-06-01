shader_type canvas_item;

uniform sampler2D img;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	// 改变坐标基点，进行线性变换 [2,-3] = 2[1,0] + -3[0,1]， 改变[1,0][0,1]两个基向量便可获得变换后的对应向量
	uv = uv.x * vec2(0.0, 1.0) + uv.y * vec2(1.1, 0.2);
	/*
		线性变换矩阵：
		uv.x * vec2(0.0, 1.0) + uv.y * vec2(1.1, 0.2) 
		等价于 	x*[0.0] + y[1.1]
				  [1.0]	   [0.2]
				
				[uv.x * 0.0 + uv.y * 1.1]
				[uv.x * 1.0 + uv.y * 0.2]
				
				[0.0] 和 [1.1] 视为两个特殊的向量，即为基向量的落脚坐标
				[1.0]	 [0.2]
				
		用这个变换矩阵 乘以任意向量可获得变换后的向量坐标
	*/
	
	vec4 texture1 = texture(img, UV);
	vec4 texture2 = texture(img, uv);
	
	// 通过大于比较去除多余像素
	if (any(greaterThan(abs(uv - 0.5), vec2(0.5)))) discard;
	COLOR = texture2;
	
	//uv.x = pow(UV.x, 2.0) / 2.0;
	//uv.y = pow(UV.y, 2.0) / 2.0;
	
	//uv = floor(uv*8.0);
	//float color = mod(uv.x+uv.y, 2.0);
	//float color = sin(uv.x+uv.y);
	//COLOR = vec4(uv, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
