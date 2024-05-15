class_name InputMove extends Object

# 捕获输入
static func catch_input():
	var velocity = Vector2.ZERO # 移动向量.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	return velocity


# @param delta: 帧循环间隔
# @param speed: 速度
# @param position: 当前坐标
# @param boundary: 移动边界
# @return position: 目标坐标
static func catch_input_move(delta, speed : int, position : Vector2, boundary : Vector2):
	var velocity = catch_input()
	if velocity.length() <= 0:
		return position # 不改变位置
	
	velocity = velocity.normalized() * speed # 归一化向量
	position += velocity * delta
	position.x = clamp(position.x, 0, boundary.x) # x轴边界检测
	position.y = clamp(position.y, 0, boundary.y) # y轴边界检测
	return position
