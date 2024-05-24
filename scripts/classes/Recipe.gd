# ======================================================================
# 名称：Recipe
# 类型：合成配方
# 简介：资源脚本，记录不同物品组合生成新物品的方
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name Recipe extends Resource

@export var name: String
@export var ingredients: Array[Item] = [] # 合成所需的材料
@export var results: Array[Item] = [] # 合成结果
