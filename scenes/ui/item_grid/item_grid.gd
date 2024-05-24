class_name ItemGrid extends GridContainer

@export var slot_scene: PackedScene
	
# 打开背包，传入库存数据
func display(items: Array[Item]):
	# 清空背包，避免与之前的数据混合
	for child in get_children():
		child.queue_free()
	
	# 遍历背包，将物品添加到背包界面
	for item in items:
		var slot = slot_scene.instantiate()
		# 必须先添加到场景中，添加到场景后实例化 slot 组件才能访问 display 方法
		add_child(slot)
		slot.display(item)
