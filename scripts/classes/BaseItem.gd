# ======================================================================
# 名称：BaseItem
# 类型：物品基类
# 简介：管理物品的碰撞拾取等
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name BaseItem extends Node2D

@export var item: Item
@export var area: Area2D

func _ready():
	# 绑定触碰区域
	area.body_entered.connect(_on_area_2d_body_entered)
	#var instance = item.scene.instantiate()
	#add_child(instance)
	
func _on_area_2d_body_entered(body):
	# 检查触碰对象是否定义了拾起 healfh_potion 的函数
	if body.has_method("on_item_picked_up"):
		# 如果有则调用这个方法将物品的KEY传过去，对方可以从物品字典或者资源中获取被拾起物品的 resources 信息
		body.on_item_picked_up(item)
		# 将被拾起的物品从场景中移除
		queue_free()

