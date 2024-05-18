# ======================================================================
# 名称：InputMove
# 类型：输入移动扩展
# 简介：将输入转换为移动标或路径
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name InputMove extends Object

# 获取输入返回移动速率向量
# @param speed: 速度
static func catch_input_move(speed: int) -> Vector2:
	var velocity = Vector2.ZERO # 移动向量
	velocity.x = Input.get_axis("move_left","move_right")
	velocity.y = Input.get_axis("move_up","move_down")
	
	return velocity.normalized() * speed  # 归一化向量后乘以速度获得移动的方向和距离
