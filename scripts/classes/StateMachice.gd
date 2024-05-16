# ======================================================================
# 名称：StateMachice
# 类型：态机
# 简介：定义状态字典，在ready遍历所有子节点，如果子节点一个状态则将它的名字加入字典
# 作者：彭亮
# Godot版本：Godot_v4.2.2-stable_win64
# ======================================================================
class_name StateMachice extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.PhysicsUpdate(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	print('current_state: ',current_state)
	print('state: ',state)
	print('new_state_name: ',new_state_name)
	print('states: ',states)
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
	
	
