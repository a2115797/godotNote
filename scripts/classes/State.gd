# ======================================================================
# 名称：State
# 类型：状态
# 简介：管理角色状态
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name State extends Node

signal Transitioned

func Enter():
	pass

func Exit():
	pass

func Update(_delta:float):
	pass

func PhysicsUpdate(_delta:float):
	pass
