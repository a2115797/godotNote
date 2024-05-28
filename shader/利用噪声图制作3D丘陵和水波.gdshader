shader_type spatial;

render_mode specular_toon;

uniform sampler2D noise; // 导出噪声图
uniform sampler2D normalmap; // 导出法线贴图

/*
uniform 定义的变量可以在GDScript 中通过 MeshInstance3D 进行调用：
mesh.material.set_shader_parameter("height_scale", 0.5)
*/ 
uniform float height_scale = 0.5;

// varying 声明全局可用但不需要导出外部操作的变量
varying vec2 tex_position;

// 顶点处理器
void vertex() {
	// 规则的波浪形山峰
	// VERTEX.y += cos(VERTEX.x * 4.0) * sin(VERTEX.z * 4.0);
	
	/*
	 	使用噪声纹理中灰度值作为该坐标的高度，
		VERTEX 的坐标范围是[-1,1],纹理的坐标系是[0,1],
		为了规范化将 VERTEX 的坐标除以 2 再加 0.5，也可以使用UV标系 (官方文档)
		实际应该根据 mesh size 来设置，[2,2]的网格就除以2
		噪声纹理是灰度图，是所有通道的值都相同的 vec4(r,g,b,a) 向量，因此随便取一个进行计算即可
	*/ 
	tex_position = VERTEX.xz / 2.0 + 0.5; // 在 fragment 中无法使用 VERTEX，因此将顶点坐标保存起来
	float height = texture(noise, tex_position).x;
	VERTEX.y = height * height_scale;

}

void fragment() {
	// 设置法线贴图
	NORMAL_MAP = texture(normalmap, tex_position).xyz;
	
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
