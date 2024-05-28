shader_type spatial;

render_mode specular_toon;

uniform sampler2D noise; // 导出噪声图

// 水波
float wave(vec2 position) {
	// 通过 noise 纹理来偏移位置. 这将会使波浪成为曲线, 所以它们将不会是与网格所对齐的直线.
	position += texture(noise, position / 10.0).x * 0.5 - 0.2;
	/*
		用 sin() 和 position 定义一个类似波浪的函数. 
		通常 sin() 波是很圆的. 我们使用 abs() 去将其绝对化, 
		让它有一个尖锐波峰, 并将其约束于0-1的范围内. 然后我们再从 1.0 中减去, 将峰值放在上方.
	*/
	vec2 wv = 1.0 - abs(sin(position));
	/*
		将x方向的波乘以y方向的波, 并将其提高到使峰值变得尖锐的幂. 
		然后从 1.0 中减去它, 使山脊成为山峰, 并提高山脊锐化的能力.
	*/ 
	return pow(1.0 - pow(wv.x * wv.y, 0.65), 4.0);
}

// 计算顶点度
float height(vec2 position, float time) {
	//// 使 positon 偏移 TIME 的余弦来使 height() 函数更加复杂
	//vec2 offset = 0.01 * cos(position + time);
	//// 根据mesh size 来设置，[10,10]的网格就除以10，或者使用UV坐标系
	//return texture(noise, position / 10.0 - offset).x;
	
	/*
		把时间加到两个上, 再从另外两个上减去. 这使得波在不同的方向上移动, 产生了复杂的效果.
	 	还要注意, 振幅(结果乘以的数字)全部加起来是 1.0. 这使波浪保持在0-1的范围内.
	*/ 
	float h = wave((position + time) * 0.4) * 0.3;
	h += wave((position - time) * 0.3) * 0.3;
	h += wave((position + time) * 0.5) * 0.2;
	h += wave((position - time) * 0.6) * 0.2;
	return h;
}

// 顶点处理器
void vertex() {
	// 使用 TIME 制作动画
	vec2 pos = VERTEX.xz;
	float k = height(pos, TIME);
	VERTEX.y = k;
	
	NORMAL = normalize(vec3(k - height(pos + vec2(0.1,0.0), TIME), 0.1, k - height(pos + vec2(0.0, 0.1), TIME)));
}

void fragment() {
	/*
		菲涅尔反射率
		用 NORMAL 和 VIEW 向量的点积获得近似菲涅尔反射率的效果
		NORMAL 向量指向远离网格表面的方向
		VIEW 向量指向你的眼睛和网格表面上的那个点之间的方向
		它们的点积可以告诉你当前是从正面还是侧面看物体表面
	*/
	float fresnel = sqrt(1.0 - dot(NORMAL,VIEW));
	
	// ALBEDO 更改反射率，可以通过调整反射光线的颜色呈现出不同的材质效果，偏蓝色的反光让材质看起来像海水
	//ALBEDO = vec3(0.1, 0.3, 0.5) + (0.1 * fresnel);
	//ALBEDO = vec3(0.1, 0.3, 1) + (0.1 * fresnel);
	ALBEDO = vec3(0.03, 0.09, 0.3) + (0.1 * fresnel);
	//ALBEDO = vec3(0.1, 0.3, 1);
	
	/* 
		PBR模型的Godot用户两个主要参数:”金属度” 和 “粗糙度”. 
		METALLIC 指定该物体有多像金属, 它最好设置为接近 0 或 1
		ROUGHNESS 指定粗糙度，低 “粗糙度” 会使材料看起来像闪亮的塑料, 而高粗糙度使材料在颜色上看起来更坚实.
	*/	
	METALLIC = 0.0; // 金属度
	ROUGHNESS = 0.01 * (1.0 - fresnel); // 粗糙度
	//ROUGHNESS = 0.01; // 粗糙度
	RIM = 0.3; // 边缘照明
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
