shader_type canvas_item;

uniform sampler2D img;
uniform vec2 size;

/*
	绘制帧动画
	uv: UV坐标 quantity：行数和列数 progress:播放进度
*/
vec2 flipbook(vec2 uv, vec2 quantity, float progress) {
	/*
		(quantity.x * quantity.y)计算总帧数，再用 progress 取模向下取整获取当前帧索引
	*/
	progress = floor( mod(progress, (quantity.x * quantity.y)) );
	// frame_size = [1/quantity.x, 1/quantity.y],假如序列帧图片是1行15列，frame_size 就是[1/15=0.066,1/1=1]
	vec2 frame_size = vec2(1.0, 1.0) / vec2(quantity.x, quantity.y);
	vec2 frame = fract(uv / quantity) + frame_size;
	
	frame.x += ( (progress / quantity.x) - frame_size.x * floor(progress / quantity.x) * quantity.x );
	frame.y += (frame_size.y * floor(progress/quantity.x)) - frame_size.y;
	
	return frame;
}

void fragment() {
	vec2 flip_uv = flipbook(UV, size, TIME * 10.);
	COLOR = texture(img, flip_uv);
}
