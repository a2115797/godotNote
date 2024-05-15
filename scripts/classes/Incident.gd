# ======================================================================
# 名称：Incident
# 类型：事件基类
# 简介：具有基础的事件响应功能
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name Incident extends Node

# =========================== 面板参数 ==================================
@export var emotional: int = 0		# 情绪值 -10到10
@export var incident_name: String			# 事件名称

var options # 事件选项
var choice
