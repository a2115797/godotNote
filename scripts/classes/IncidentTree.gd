# ======================================================================
# 名称：IncidentTree
# 类型：事件树基类
# 简介：定义状态字典组织事件，在ready遍历所有子节点，如果子节点一个状态则将它的名字加入字典
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name IncidentTree extends Node

@export var incidents: Dictionary # 以发生的事件

func _ready():
	for child in get_children():
		incidents[child.name.to_lower()] = child
