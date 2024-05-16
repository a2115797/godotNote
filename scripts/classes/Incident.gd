# ======================================================================
# 名称：Incident
# 类型：事件基类
# 简介：管理剧情场景、用户抉择、抉择结果间的关系，不作任何内容展示。具体内容展示由绑定的剧情场景来完成
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name Incident extends Node

# =========================== 面板参数 ==================================
@export var incident_name: String			# 事件名称

@export var drama: Node			# 剧情场景
@export var ending: Array[Node]	# 结局
var options			# 事件选项
var choice			# 用户选择
