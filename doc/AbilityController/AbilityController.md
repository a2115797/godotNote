# 能力控制
生成 abiliy 节点并添加到对应位置，节点生成后可以在 AnimationPlayer 中添加 queue_free() 函数进行销毁，或是在 abiliy 节点中通过代码进行销毁

```
extends Node

# 最大范围
@export var max_range: int = 150

# 导出能力场景，在控制器场景进行挂在需要管理的能力
@export var sword_ability: PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("Player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("Enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		# 计算 enemy 和 player 之间距离的平方是否小于 max_range 的2次幂
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	if enemies.size() == 0:
		return
	
	# 自定义排序，距离 player 更近的排前边
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
		
	# 实例化场景并将其添加 player 的父节点,并将其设置为 enemy 节点的当前位置
	var sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	# 将 sword_instance 移动到附近的随机位置，右边矢量随机旋转0-360° 乘以 4 的偏移量
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	# 计算攻击的 enemy 与 ability 位置矢量 
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
```