shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	// 生成棋盘格方法一
	//float size =10.0; // 棋盘格数量
	//uv = uv * size;
	//// fract : Fractional (returns x - floor(x)), 取小数
	//// 乘以 0.5 取Y轴红色的一半色值，y大于0.5的值为0，小于0.5的1*0.5= 0.5
	//float xOffset = step(fract(uv.y), 0.5) * 0.5;
	///*
		//fract(uv.x + xOffset) 加上x轴偏移量，y轴值为0/0.5， 
		//x为0-0.5 y为0-0.5（xOffset=0.5）时， 0到0.5 + 0.5 = [0.5，1]，向下取整为0，[0.5,1]-0=[0.5,1],大于0.5，因此值x[0,0.5]-y[0,0.5]区域色值为0
		//x为0.5-1 y为0-0.5（xOffset=0.5）时，0.5到1 + 0.5 = [1,1.5]向下取整为1,[1,1.5]-1=[0,0.5],小于0.5，因此x[0.5,1]-y[0,0.5]区域色值为1
		//x为0-0.5 y为0.5-1（xOffset=0）时， fract(uv.x + xOffset) = [0, 0.5] 小于0.5， 因此 x[0, 0.5]-y[0.5-1]区域色值为 1
		//x为0.5-1 y为0.5-1（xOffset=0）时， fract(uv.x + xOffset) = [0.5, 1] 大于0.5， 因此 x[0.5, 1]-y[0.5-1]区域色值为 0
	//*/ 
	//float xyOffset = step(fract(uv.x + xOffset), 0.5);
	//COLOR = vec4(xyOffset, 0.0, 0.0, 1.0);
	
	// 方法2
	//uv = sin(uv*50.); // uv乘以缩放倍率，sin 返回-1到1之间的值
	//// ceil 向上取整x*y，获得小于0的值为0，大于0的值为1,xy和-x-y区间为1，-xy和x-y区间为0
	//COLOR = vec4(ceil(uv.x*uv.y), 0.0, 0.0, 1.0);
	
	// 方法三
	//uv = floor(uv*5.0);
	//// mod 对2.0取模， (1+1)/2=0,()
	//COLOR = vec4(mod(uv.x+uv.y, 2.0), 0.0, 0.0, 1.0);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
