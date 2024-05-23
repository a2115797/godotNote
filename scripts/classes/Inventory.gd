# ======================================================================
# 名称：Inventory
# 类型：背包/仓库基类
# 简介：用于存物品信息
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name Inventory extends RefCounted

var _content: Array[Item] = []

func add_item(item:Item):
	_content.append(item)

func remove_item(item:Item):
	_content.erase(item)

func get_items() -> Array[Item]:
	return _content
