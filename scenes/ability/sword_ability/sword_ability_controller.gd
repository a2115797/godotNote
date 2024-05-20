extends Node

@export var sword_ability: PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if player == null:
		return
		
	# 实例化场景并将其添加 player 的父节点,并将其设置为 player 节点的当前位置
	var sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = player.global_position
