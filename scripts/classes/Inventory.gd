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

# 获取库存列表
func get_items() -> Array[Item]:
	return _content

# 是否拥有传入的有物品
func has_all(items: Array[Item]) -> bool:
	# 复制数组，避免更改原数组
	var needed: Array[Item] = items.duplicate()
	
	# 遍历库存和需要的物品，如果库存内拥有需要的物品则将物品从 needed 数组中移除
	for available in _content:
		needed.erase(available) # 使用 erase 函数移除 available,不存在则不会发生任何事情
		
	return needed.is_empty()
	
